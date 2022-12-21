//
// Created by Dave Ingle
// Copyright © 2022 Dialpad Inc. All rights reserved.
//

import SwiftUI
import CosmicEventList

import APIClient
import ComposableArchitecture
import SharedModels

@main
struct CosmicEventsApp: App {

    let rootStore: StoreOf<CosmicEventList> = {
        return StoreOf<CosmicEventList>(
            initialState: CosmicEventList.State(),
            reducer: CosmicEventList()
        )
    }()

    var body: some Scene {
        WindowGroup { CosmicEventList.SwiftUI(store: rootStore) }
    }
}
