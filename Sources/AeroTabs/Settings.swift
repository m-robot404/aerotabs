import Foundation

enum DisplayMode: String, CaseIterable {
    case iconAndNameAll = "iconAndNameAll"
    case iconAndNameActive = "iconAndNameActive"
    case iconOnly = "iconOnly"

    var label: String {
        switch self {
        case .iconAndNameAll: return "Icon + Name (All)"
        case .iconAndNameActive: return "Icon + Name (Active Only)"
        case .iconOnly: return "Icon Only"
        }
    }

    func showLabel(isActive: Bool) -> Bool {
        switch self {
        case .iconAndNameAll: return true
        case .iconAndNameActive: return isActive
        case .iconOnly: return false
        }
    }
}

class Settings {
    private let defaults: UserDefaults
    private static let displayModeKey = "displayMode"
    private static let showWorkspaceNumberKey = "showWorkspaceNumber"

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }

    var displayMode: DisplayMode {
        get {
            guard let raw = defaults.string(forKey: Settings.displayModeKey),
                  let mode = DisplayMode(rawValue: raw) else {
                return .iconAndNameAll
            }
            return mode
        }
        set {
            defaults.set(newValue.rawValue, forKey: Settings.displayModeKey)
        }
    }

    var showWorkspaceNumber: Bool {
        get {
            guard defaults.object(forKey: Settings.showWorkspaceNumberKey) != nil else {
                return true
            }
            return defaults.bool(forKey: Settings.showWorkspaceNumberKey)
        }
        set {
            defaults.set(newValue, forKey: Settings.showWorkspaceNumberKey)
        }
    }
}
