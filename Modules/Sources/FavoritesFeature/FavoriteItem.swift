//
// Created by Dave Ingle
// Copyright © 2022 Dialpad Inc. All rights reserved.
//

import Foundation
import ComposableArchitecture
import SharedModels

public struct FavoriteItem: ReducerProtocol {

    public func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .didAppear: return .none
        }
    }
}

extension FavoriteItem {

    public enum Action {
        case didAppear
    }
}

extension FavoriteItem {

    public struct State: Equatable, Identifiable {
        public var id: MarvelCharacter.ID { itemID }

        public var itemID: MarvelCharacter.ID

        public init(itemID: MarvelCharacter.ID) {
            self.itemID = itemID
        }

        public init(character: MarvelCharacter) {
            self.itemID = character.id
        }
    }
}
