//
// Created by Dave Ingle
// Copyright © 2022 Dialpad Inc. All rights reserved.
//

import ComposableArchitecture
import Foundation
import XCTestDynamicOverlay
import APIClient
import SharedModels

public struct CosmicEventList: ReducerProtocol {
    public init() {}

    @Dependency(\.apiClient) var apiClient

    public func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .bootstrap:
            return .task {
                let payload = try await apiClient.fetchEvents(cursor: nil)
                return .didReceiveEvents(payload)
            }

        case .eventDidAppear(let id):
            if id == state.events.last?.id {
                let offset = state.events.count
                let cursor = Cursor(offset: offset, limit: 20)
                return .task {
                    let payload = try await apiClient.fetchEvents(cursor: cursor)
                    return .didReceiveEvents(payload)
                }
            }
            return .none

        case .didReceiveEvents(let payload):
            state.cursor = payload.data.cursor
            let newEvents = payload.data.results
            state.events.append(contentsOf: newEvents)
            return .none
        }
    }

}

extension CosmicEventList {

    public enum Action: Equatable {
        case bootstrap
        case eventDidAppear(CosmicEvent.ID)
        case didReceiveEvents(APIPayload<CosmicEvent>)
    }
}


extension CosmicEventList {

    public struct State: Equatable {
        public var events: IdentifiedArrayOf<CosmicEvent>
        public var filter: String
        public var cursor: Cursor?

        public init(
            events: IdentifiedArrayOf<CosmicEvent> = [],
            filter: String = ""
        ) {
            self.events = events
            self.filter = filter
        }
    }
}
