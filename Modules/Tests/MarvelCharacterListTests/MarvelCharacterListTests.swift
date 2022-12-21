//
// Created by Dave Ingle
// Copyright © 2022 Dialpad Inc. All rights reserved.
//

import XCTest

@testable import MarvelCharacterList

import ComposableArchitecture
import MarvelData

@MainActor final class MarvelCharacterListTests: XCTestCase {

    func testBootstrap() async {
        let (marvelCharacters, receiveCharacters) = AsyncStream<MarvelDataClient.Message>.streamWithContinuation()

        let store = TestStore(
            initialState: MarvelCharacterList.State(),
            reducer: MarvelCharacterList()
        )
        store.dependencies.marvelDataClient.connect = { _ in marvelCharacters }

        let task = await store.send(.bootstrap)

        receiveCharacters.yield(.placeholder)

        await store.receive(.didReceiveCharacters(.placeholder))

        await task.cancel()

        receiveCharacters.yield(.placeholder)
    }

}
