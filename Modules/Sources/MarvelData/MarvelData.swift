//
// Created by Dave Ingle
// Copyright © 2022 Dialpad Inc. All rights reserved.
//

import Foundation
import ComposableArchitecture
@_exported import SharedModels

extension DependencyValues {
    public var marvelDataClient: MarvelDataClient {
        get { self[MarvelDataClient.self] }
        set { self[MarvelDataClient.self] = newValue }
    }
}

public struct MarvelDataClient {
    public enum Message {
        case placeholder
    }

    public var connect: @Sendable (Any.Type) async -> AsyncStream<Message>

    public var subscribe: @Sendable (Any.Type, AnyQueryScope) async -> AsyncStream<Delta>

}

extension MarvelDataClient {


    // subscribe to "marvel character" packages
    // batch updates?

    // interal flow is:
    // connect to client
    // subscribe to scope with cursor/filter
    // send any cached items along channel
    // request items if needed
    // send returned items along channel


    // concepts: connect, subscribe, refresh, filter, cursor, page, etag?
}


/*
 Inputs: PushNotifications, Persistence, APIClient


 */

