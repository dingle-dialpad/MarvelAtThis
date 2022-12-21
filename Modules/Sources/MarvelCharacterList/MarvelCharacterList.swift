//
// Created by Dave Ingle
// Copyright © 2022 Dialpad Inc. All rights reserved.
//

import Foundation
import ComposableArchitecture
import XCTestDynamicOverlay
import APIClient
import SharedModels

public struct MarvelCharacterList: ReducerProtocol {
    public init() {}

    @Dependency(\.apiClient) var apiClient

    public func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        struct MarvelDataConnection {}
        switch action {
        case .bootstrap:
            return .task { [cursor = state.cursor] in
                let payload = try await apiClient.fetchCharacters(
                    cursor: cursor
                )
                return .didReceiveCharacters(payload)
            }

        case .updateSortOrder(let sortOrder):
            state.sortOrder = sortOrder
            return .none

        case .characterDidAppear(let id):
            if id == state.characters.last?.id {
                let offset = state.characters.count
                let cursor = Cursor(offset: offset, limit: 20)
                return .task {
                    let payload = try await apiClient.fetchCharacters(cursor: cursor)
                    return .didReceiveCharacters(payload)
                }
            }
            return .none

        case .didReceiveCharacters(let payload):
            state.cursor = payload.data.cursor
            state.characters.append(contentsOf: payload.data.results)
            return .none

        case .favorite:            
            return .none
        }
    }

}

extension MarvelCharacterList {

    public enum Action: Equatable {
        case bootstrap
        case updateSortOrder(MarvelCharacterList.OrderBy)
        case characterDidAppear(MarvelCharacter.ID)
        case didReceiveCharacters(APIPayload<MarvelCharacter>)
        case favorite(MarvelCharacter.ID)
    }
}

extension MarvelCharacterList {

    public struct State: Equatable {
        var characters: IdentifiedArrayOf<MarvelCharacter>
        var sortOrder = OrderBy.name
        var cursor: Cursor = Cursor(offset: 0, limit: 20)

        public init(characters: IdentifiedArrayOf<MarvelCharacter> = []) {
            self.characters = characters
        }
    }

    public enum OrderBy: String, CaseIterable {
        case name = "Name"
        case recents = "Recents"
    }
}

extension MarvelCharacterList {

//    public struct ListItem: Equatable, Identifiable, Sendable {
//        public var id: Int
//        public var thumbnailURL: URL
//        public var title: String
//        public var body: String
//        public var isFavorite: Bool
//        public var storyCount: Int
//        public var lastModified: Date
//
//        public init(id: Int, thumbnailURL: URL, title: String, body: String, isFavorite: Bool, storyCount: Int, lastModified: Date) {
//            self.id = id
//            self.thumbnailURL = thumbnailURL
//            self.title = title
//            self.body = body
//            self.isFavorite = isFavorite
//            self.storyCount = storyCount
//            self.lastModified = lastModified
//        }
//    }
}
