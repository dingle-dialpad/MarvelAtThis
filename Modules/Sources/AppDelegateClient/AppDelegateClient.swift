//
// Created by Dave Ingle
// Copyright © 2022 Dialpad Inc. All rights reserved.
//

import Foundation
import Dependencies
import ComposableArchitecture

extension DependencyValues {
    public var appLifeCycle: AppDelegateClient {
        get { self[AppDelegateClient.self] }
        set { self[AppDelegateClient.self] = newValue }
    }
}

public struct AppDelegateClient {
    public var stream: @Sendable () -> AsyncStream<LifeCycleEvent>

    public init(stream: @Sendable @escaping () -> AsyncStream<LifeCycleEvent>) {
        self.stream = stream
    }
}

public enum LifeCycleEvent: Equatable {
    case didFinishLaunching
    case didRegisterForRemoteNotifications(TaskResult<Data>)
}
