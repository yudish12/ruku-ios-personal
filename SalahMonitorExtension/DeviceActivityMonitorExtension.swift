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
        NSLog("Starting shield for activity: %@", activity.rawValue)

        let selection = ShieldStore.shared.selection

        store.shield.applications = selection.applicationTokens
        defaults?.set(true, forKey: "isBlockingActive")

    }

    override func intervalDidEnd(for activity: DeviceActivityName) {
        NSLog("end blocking now")
        store.shield.applications = nil
        defaults?.set(false, forKey: "isBlockingActive")
    }
}
