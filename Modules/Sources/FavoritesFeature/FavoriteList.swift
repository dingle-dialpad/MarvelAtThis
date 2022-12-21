//
// Created by Dave Ingle
// Copyright © 2022 Dialpad Inc. All rights reserved.
//

import Foundation
import ComposableArchitecture
import XCTestDynamicOverlay
import SharedModels

public struct FavoriteList: ReducerProtocol {

//    @Dependency(\.marvelDataClient) var dataClient

    public var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .bootstrap:
                return .none

            case .delete(let indexSet):
                state.favorites.remove(atOffsets: indexSet)
                return .none

            case .move(let indexSet, let destination):
                state.favorites.move(fromOffsets: indexSet, toOffset: destination)
                return .none

            case .favorite:
                return .none
            }
        }.forEach(\.favorites, action: /Action.favorite, FavoriteItem.init)
    }

}

extension FavoriteList {

    public enum Action: Equatable {
        case bootstrap
        case favorite(id: FavoriteItem.State.ID, action: FavoriteItem.Action)
        case delete(IndexSet)
        case move(IndexSet, Int)
    }
}

extension FavoriteList {

    public struct State: Equatable {
        public var featureStack: [ChildFeature] = []
        public var favorites: IdentifiedArrayOf<FavoriteItem.State> = []

        public init(favorites: IdentifiedArrayOf<FavoriteItem.State> = []) {
            self.favorites = favorites
        }
    }
}

extension FavoriteList {

    public enum ChildFeature: Equatable {
        case characterDetails(id: MarvelCharacter.ID)
    }
}
