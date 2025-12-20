import DeviceActivity
import ManagedSettings
import FamilyControls
import Foundation

final class DeviceActivityMonitorExtension: DeviceActivityMonitor {

    private let store = ManagedSettingsStore()
    private let defaults = UserDefaults(
        suiteName: "group.com.yud.Ruku"
    )

    override func intervalDidStart(for activity: DeviceActivityName) {
        NSLog("🚨 Activity: %@", activity.rawValue)

        let selection = ShieldStore.shared.selection
        NSLog("🚨 App tokens count: %d", selection.applicationTokens.count)

        store.shield.applications = selection.applicationTokens
        defaults?.set(true, forKey: "isBlockingActive")

        NSLog("🚨 SHIELD APPLIED 🚨")
    }

    override func intervalDidEnd(for activity: DeviceActivityName) {
        NSLog("🚨🚨🚨 EXTENSION ENDED 🚨🚨🚨")
        store.shield.applications = nil
        defaults?.set(false, forKey: "isBlockingActive")
    }
}
