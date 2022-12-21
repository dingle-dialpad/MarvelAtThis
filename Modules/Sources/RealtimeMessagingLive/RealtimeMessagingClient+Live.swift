//
// Created by Dave Ingle
// Copyright © 2022 Dialpad Inc. All rights reserved.
//

import Foundation
@_exported import RealtimeMessaging

import Ably
import ComposableArchitecture

extension RealtimeMessagingClient: DependencyKey {

    public static var liveValue: RealtimeMessagingClient {
        return RealtimeMessagingClient(
            connect: { await AblyActor.shared.connect() },
            registerDeviceToken: { await AblyActor.shared.registerDeviceToken($0) },
            subscribe: { await AblyActor.shared.subscribe(channel: $0) }
        )

    }

}

extension RealtimeMessagingClient {

    final actor AblyActor: GlobalActor {
        final class Delegate: NSObject, ARTPushRegistererDelegate {
            var continuation: AsyncStream<Action>.Continuation?

            func didActivateAblyPush(_ error: ARTErrorInfo?) {
                self.continuation?.yield(.didActivate)
            }

            func didDeactivateAblyPush(_ error: ARTErrorInfo?) {
                self.continuation?.yield(.didDeactivate)
                self.continuation?.finish()
            }
        }

        static let shared = AblyActor()

        typealias Dependencies = (client: ARTRealtime, delegate: Delegate)

        var dependencies: Dependencies?

        func connect() -> AsyncStream<Action> {
            let delegate = Delegate()

            let options = ARTClientOptions()
            options.key = ""
            options.pushRegistererDelegate = delegate
            let client = ARTRealtime(options: options)

            dependencies = (client, delegate)
            var continuation: AsyncStream<Action>.Continuation!
            let stream = AsyncStream<Action> {
                $0.onTermination = { _ in
                    Task { await self.removeDependencies() }
                }
                continuation = $0
            }
            dependencies!.delegate.continuation = continuation


            return stream
        }

        func registerDeviceToken(_ deviceToken: Data) {
            guard let client = dependencies?.client else {
                fatalError()
            }

            ARTPush.didRegisterForRemoteNotifications(withDeviceToken: deviceToken, realtime: client)
            client.push.activate()
            client.connect()
        }

        func subscribe(channel: Channel) -> AsyncStream<Message> {
            guard let client = dependencies?.client else { return .finished }

            let channel: ARTRealtimeChannel = client.channels.get(channel.rawValue)
            return AsyncStream<Message> { continuation in
                channel.subscribe { (message: ARTMessage) in
                    let name = message.name ?? ""
                    let data = message.data.flatMap { try? JSONSerialization.data(withJSONObject:$0) }
                    continuation.yield(Message(name: name, data: data ?? Data()))
                }
            }
        }

        private func removeDependencies() {
            self.dependencies = nil
        }
    }
}
