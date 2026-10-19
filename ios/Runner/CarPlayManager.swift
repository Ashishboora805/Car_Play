import CarPlay
import Flutter
import UIKit

/// Native templates only. audio_service owns Now Playing and remote commands.
final class CarPlayManager {
  private var strings = UserDefaults.standard.dictionary(forKey: "cpdrive.car.strings") as? [String: String] ?? [:]
  private func text(_ key: String) -> String { strings[key] ?? (key == "loading" ? "..." : "CP Drive") }
  private func updateStrings(_ value: [String: Any]?) {
    if let incoming = value?["strings"] as? [String: String] {
      strings = incoming
      UserDefaults.standard.set(incoming, forKey: "cpdrive.car.strings")
    }
  }
  private let channel: FlutterMethodChannel
  private weak var controller: CPInterfaceController?
  private var timer: Timer?
  private var retry: DispatchWorkItem?
  private var timeout: DispatchWorkItem?
  private var epoch = 0
  private var request = 0
  private var loading = false
  private var refreshPending = false
  private var startupAttempts = 0
  private var order: [String] = []
  private var lists: [String: CPListTemplate] = [:]
  private var statusList: CPListTemplate?
  private var tabBar: CPTabBarTemplate?
  private lazy var logo: UIImage? = {
    let key = FlutterDartProject.lookupKey(forAsset: "assets/images/logo.png")
    guard let path = Bundle.main.path(forResource: key, ofType: nil),
          let image = UIImage(contentsOfFile: path) else { return nil }
    let maximum = CPListItem.maximumImageSize
    guard image.size.width > 0, image.size.height > 0 else { return nil }
    let scale = min(maximum.width / image.size.width, maximum.height / image.size.height)
    let size = CGSize(width: image.size.width * scale, height: image.size.height * scale)
    return UIGraphicsImageRenderer(size: size).image { _ in
      image.draw(in: CGRect(origin: .zero, size: size))
    }
  }()

  init(channel: FlutterMethodChannel) {
    self.channel = channel
    channel.setMethodCallHandler { [weak self] call, result in
      guard let self = self else { result(nil); return }
      self.updateStrings(call.arguments as? [String: Any])
      switch call.method {
      case "ready", "changed":
        self.startupAttempts = 0
        self.refresh()
        result(nil)
      default: result(FlutterMethodNotImplemented)
      }
    }
  }

  func connect(_ interfaceController: CPInterfaceController) {
    if let old = controller { disconnect(old) }
    epoch += 1
    controller = interfaceController
    startupAttempts = 0
    showStatus(text("loading"))
    timer = Timer.scheduledTimer(withTimeInterval: 120, repeats: true) { [weak self] _ in
      self?.refresh()
    }
    refresh()
  }

  func disconnect(_ interfaceController: CPInterfaceController) {
    guard controller === interfaceController else { return }
    epoch += 1
    request += 1
    timer?.invalidate()
    timer = nil
    retry?.cancel()
    retry = nil
    timeout?.cancel()
    timeout = nil
    loading = false
    refreshPending = false
    lists.removeAll()
    order.removeAll()
    statusList = nil
    tabBar = nil
    controller = nil
    // Release car templates without stopping the shared engine or phone audio.
  }

  private func messageRow(_ message: String) -> CPListItem {
    let item = CPListItem(text: message, detailText: nil, image: logo)
    item.isEnabled = false
    return item
  }

  private func showStatus(_ message: String) {
    guard let controller = controller else { return }
    let sections = [CPListSection(items: [messageRow(message)])]
    if let statusList = statusList {
      statusList.updateSections(sections)
      return
    }
    let template = CPListTemplate(title: "CP Drive", sections: sections)
    statusList = template
    lists.removeAll()
    order.removeAll()
    tabBar = nil
    controller.setRootTemplate(template, animated: false, completion: nil)
  }

  private func refresh() {
    guard controller != nil else { return }
    if loading { refreshPending = true; return }
    retry?.cancel()
    loading = true
    refreshPending = false
    request += 1
    let token = request
    let connection = epoch
    let deadline = DispatchWorkItem { [weak self] in
      guard let self = self, self.epoch == connection, self.request == token else { return }
      self.request += 1
      self.loading = false
      self.showStatus(self.text("matchesError"))
      if self.refreshPending { self.refresh() }
    }
    timeout = deadline
    DispatchQueue.main.asyncAfter(deadline: .now() + 30, execute: deadline)
    channel.invokeMethod("getLists", arguments: nil) { [weak self] value in
      guard let self = self, self.epoch == connection, self.request == token,
            self.controller != nil else { return }
      self.timeout?.cancel()
      self.timeout = nil
      self.loading = false
      if self.refreshPending { self.refresh(); return }
      if let data = value as? [String: Any] {
        self.startupAttempts = 0
        self.apply(data)
      } else if self.startupAttempts < 15 {
        // CarPlay can connect before Dart installs its handler.
        self.startupAttempts += 1
        let retry = DispatchWorkItem { [weak self] in self?.refresh() }
        self.retry = retry
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: retry)
      } else {
        self.showStatus(self.text("audioError"))
      }
      if self.refreshPending { self.refresh() }
    }
  }

  private func apply(_ snapshot: [String: Any]) {
    updateStrings(snapshot)
    guard snapshot["status"] as? String == "ready",
          let rawTabs = snapshot["tabs"] as? [[String: Any]], !rawTabs.isEmpty else {
      showStatus(snapshot["message"] as? String ?? text("matchesError"))
      return
    }
    let tabs = Array(rawTabs.prefix(CPTabBarTemplate.maximumTabCount))
    let ids = tabs.compactMap { $0["id"] as? String }
    guard ids.count == tabs.count, Set(ids).count == ids.count else {
      showStatus(text("matchesError"))
      return
    }
    let unchanged = ids == order && tabBar != nil && tabs.allSatisfy {
      guard let id = $0["id"] as? String else { return false }
      return lists[id]?.title == $0["title"] as? String
    }
    var updated: [CPListTemplate] = []
    for tab in tabs {
      guard let id = tab["id"] as? String else { continue }
      let title = tab["title"] as? String ?? text("matches")
      let rawItems = tab["items"] as? [[String: Any]] ?? []
      let rows: [CPListItem] = rawItems.prefix(min(20, CPListTemplate.maximumItemCount)).map { data in
        let item = CPListItem(text: data["title"] as? String ?? text("match"),
                              detailText: data["detail"] as? String, image: logo)
        if data["playable"] as? Bool == true, let mediaID = data["id"] as? String {
          item.handler = { [weak self] _, completion in
            guard let self = self else { completion(); return }
            self.play(mediaID, completion: completion)
          }
        } else { item.isEnabled = false }
        return item
      }
      let section = CPListSection(items: rows.isEmpty ? [messageRow(text("empty"))] : rows)
      let template: CPListTemplate
      if unchanged, let existing = lists[id] {
        template = existing
        template.tabTitle = title
        template.updateSections([section])
      } else {
        template = CPListTemplate(title: title, sections: [section])
        template.tabTitle = title
        let symbol: String
        switch id {
        case "folder:live": symbol = "dot.radiowaves.left.and.right"
        case "folder:upcoming": symbol = "calendar"
        case "folder:results": symbol = "flag.checkered"
        default: symbol = "person.crop.circle"
        }
        template.tabImage = UIImage(systemName: symbol)
      }
      lists[id] = template
      updated.append(template)
    }
    if !unchanged {
      lists = lists.filter { ids.contains($0.key) }
      order = ids
      statusList = nil
      let root = CPTabBarTemplate(templates: updated)
      tabBar = root
      controller?.setRootTemplate(root, animated: false, completion: nil)
    }
  }

  private func play(_ id: String, completion: @escaping () -> Void) {
    let connection = epoch
    var finished = false
    let finish: (String?) -> Void = { [weak self] error in
      guard !finished else { return }
      finished = true
      completion() // Always dismiss the selection spinner, including disconnect/error.
      guard let self = self, self.epoch == connection, let controller = self.controller else { return }
      if let error = error { self.showStatus(error) }
      else if !(controller.topTemplate is CPNowPlayingTemplate) {
        controller.pushTemplate(CPNowPlayingTemplate.shared, animated: true, completion: nil)
      }
    }
    let unavailable = text("matchError")
    let deadline = DispatchWorkItem { finish(unavailable) }
    DispatchQueue.main.asyncAfter(deadline: .now() + 35, execute: deadline)
    channel.invokeMethod("playFromMediaId", arguments: ["id": id]) { value in
      deadline.cancel()
      guard let response = value as? [String: Any], response["ok"] as? Bool == true else {
        let response = value as? [String: Any]
        finish(response?["message"] as? String ?? unavailable)
        return
      }
      finish(nil)
    }
  }
}
