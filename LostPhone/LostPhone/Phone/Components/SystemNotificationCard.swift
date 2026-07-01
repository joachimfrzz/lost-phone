import SwiftUI

/// Carte notification verrou (style iOS).
struct SystemNotificationCard: View {
    let notification: RuntimeNotification
    var compact = false

    var body: some View {
        IOSNotificationRow(notification: notification)
    }
}
