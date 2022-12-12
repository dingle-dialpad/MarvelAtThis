//
// Created by Dave Ingle
// Copyright © 2022 Dialpad Inc. All rights reserved.
//

import Foundation
import ComposableArchitecture
import XCTestDynamicOverlay

public struct MarvelCharacterList: ReducerProtocol {

    @Dependency(\.marvelCharacters) var marvelCharacters

    public func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .bootstrap:
            return .run { send in
                for await items in await self.marvelCharacters() {
                    await send(.didReceiveCharacters(items))
                }
            }

        case .didReceiveCharacters(let items):
            state.characters += items
            return .none
        }
    }

}

extension MarvelCharacterList {

    public enum Action: Equatable {
        case bootstrap
        case didReceiveCharacters([MarvelCharacterList.ListItem])
    }
}

extension DependencyValues {
    var marvelCharacters: @Sendable () async -> AsyncStream<[MarvelCharacterList.ListItem]> {
        get { self[MarvelData.CharactersKey.self] }
        set { self[MarvelData.CharactersKey.self] = newValue }
    }
}

enum MarvelData {
    enum CharactersKey: TestDependencyKey {
        static let testValue: @Sendable () async -> AsyncStream<[MarvelCharacterList.ListItem]> =
        unimplemented(#"@Dependency(\.marvelCharacters)"#, placeholder: .finished)
    }
}


