//
// Created by Dave Ingle
// Copyright © 2022 Dialpad Inc. All rights reserved.
//

import ComposableArchitecture
import Foundation
import UserNotifications

extension UserNotificationsClient: DependencyKey {
    private static let options: UNAuthorizationOptions = [
        .alert, .badge, .sound
    ]

    public static let liveValue: UserNotificationsClient = {
        return Self(
            register: {
                let status = await UNUserNotificationCenter.current()
                    .notificationSettings()
                    .authorizationStatus

                if status != .provisional || status != .authorized {
                    return try await UNUserNotificationCenter.current()
                        .requestAuthorization(options: options)
                } else {
                    return true
                }
            }
        )
    }()

    final class Delegate: NSObject, UNUserNotificationCenterDelegate {

        func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
            completionHandler()
        }

        func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification) async -> UNNotificationPresentationOptions {
            [.badge, .banner, .list, .sound]
        }
    }
}
