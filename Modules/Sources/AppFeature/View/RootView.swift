//
// Created by Dave Ingle
// Copyright © 2022 Dialpad Inc. All rights reserved.
//

import SwiftUI
import ComposableArchitecture
import MarvelCharacterList
import CosmicEventList
import FavoritesFeature

public struct RootView: View {
    let store: StoreOf<CompositionRoot>
    @ObservedObject var viewStore: ViewStoreOf<CompositionRoot>

    public init(store: StoreOf<CompositionRoot>) {
        self.store = store
        self.viewStore = ViewStore(store)
    }

    public var body: some View {
        TabView(selection: viewStore.binding(
            get: \.selectedTab,
            send: AppAction.selectTab)
        ) {
            MarvelCharacterList.SwiftUI(
                store: self.store.scope(
                    state: \.characters,
                    action: AppAction.marvelCharacters
                )
            )
            .tag(AppState.Tab.characters)
            .tabItem { Label("Characters", systemImage: "figure.surfing") }

            CosmicEventList.SwiftUI(
                store: self.store.scope(
                    state: \.events,
                    action: AppAction.cosmicEvents
                )
            )
            .tag(AppState.Tab.events)
            .tabItem { Label("Events", systemImage: "calendar.badge.exclamationmark")}

            FavoriteList.SwiftUI(
                store: self.store.scope(
                    state: \.favorites,
                    action: AppAction.favorites
                )
            )
            .tag(AppState.Tab.favorites)
            .tabItem { Label("Favorites", systemImage: "star.circle.fill") }
        }
    }
}
