//
// Created by Dave Ingle
// Copyright © 2022 Dialpad Inc. All rights reserved.
//

import XCTest

@testable import FavoritesFeature
@testable import SharedModels

import ComposableArchitecture
import MarvelData

@MainActor final class FavoritesFeatureTests: XCTestCase {

    func test_reorderingFavorites() async throws {
        let testStore = TestStore(
            initialState: FavoriteList.State(
                favorites: [
                    .init(character: .mock(1)),
                    .init(character: .mock(2)),
                    .init(character: .mock(3))
                ]
            ),
            reducer: FavoriteList()
        )

        await testStore.send(.move(IndexSet([1]), 0)) {
            $0.favorites = [
                .init(character: .mock(2)),
                .init(character: .mock(1)),
                .init(character: .mock(3))
            ]
        }
    }

    func test_removingFavorites() async throws {
        let testStore = TestStore(
            initialState: FavoriteList.State(
                favorites: [
                    .init(character: .mock(1)),
                    .init(character: .mock(2)),
                    .init(character: .mock(3))
                ]
            ),
            reducer: FavoriteList()
        )

        await testStore.send(.delete(IndexSet([1,2]))) {
            $0.favorites = [.init(itemID: 1)]
        }
    }

}
