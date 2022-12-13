//
// Created by Dave Ingle
// Copyright © 2022 Dialpad Inc. All rights reserved.
//

import XCTest

@testable import MarvelCharacterList

import ComposableArchitecture

@MainActor final class MarvelCharacterListTests: XCTestCase {

    func testBootstrap() async {
        let (marvelCharacters, receiveCharacters) = AsyncStream<[MarvelCharacterList.ListItem]>.streamWithContinuation()

        let store = TestStore(
            initialState: MarvelCharacterList.State(),
            reducer: MarvelCharacterList()
        )

        store.dependencies.marvelDataClient = .testValue

        let task = await store.send(.bootstrap)

        receiveCharacters.yield([])

//        await store.receive(.didReceiveCharacters([]))

        await task.cancel()

        receiveCharacters.yield([])
    }

}
