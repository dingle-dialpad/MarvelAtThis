//
// Created by Dave Ingle
// Copyright © 2022 Dialpad Inc. All rights reserved.
//

import UIKit
import enum ComposableArchitecture.TaskResult

public final class AppDelegate: UIResponder, UIApplicationDelegate {
    public typealias LaunchOptions = [UIApplication.LaunchOptionsKey : Any]

    public let stream: AsyncStream<LifeCycleEvent>
    private let continuation: AsyncStream<LifeCycleEvent>.Continuation

    override public init() {
        (stream, continuation) = AsyncStream<LifeCycleEvent>.streamWithContinuation()
    }

    public func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions options: LaunchOptions? = nil
    ) -> Bool {
        continuation.yield(.didFinishLaunching)
        return true
    }

    public func application(
        _ application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {
        continuation.yield(.didRegisterForRemoteNotifications(.success(deviceToken)))
    }

    public func application(
        _ application: UIApplication,
        didFailToRegisterForRemoteNotificationsWithError error: Error
    ) {
        continuation.yield(.didRegisterForRemoteNotifications(.failure(error)))
    }

}

extension AppDelegateClient {

    public static func live(delegate: AppDelegate) -> Self {
        Self(stream: { delegate.stream })
    }
}
