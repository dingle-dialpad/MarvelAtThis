//
// Created by Dave Ingle
// Copyright © 2022 Dialpad Inc. All rights reserved.
//

import SwiftUI
import MarvelCharacterList

import APIClient
import ComposableArchitecture
import SharedModels

@main
struct MarvelCharactersApp: App {

    let rootStore: StoreOf<MarvelCharacterList> = {
        return StoreOf<MarvelCharacterList>(
            initialState: MarvelCharacterList.State(),
            reducer: MarvelCharacterList()
        )
    }()

    var body: some Scene {
        WindowGroup { MarvelCharacterList.SwiftUI(store: rootStore) }
    }
}
