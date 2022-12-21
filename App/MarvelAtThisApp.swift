//
//  MarvelAtThisApp.swift
//  MarvelAtThis
//
//  Created by David Ingle on 2022-12-16.
//

import SwiftUI
import AppDelegateClient
import AppFeature
import ComposableArchitecture

@main
struct MarvelAtThisApp: App {

    @UIApplicationDelegateAdaptor private var delegate: AppDelegate

    var store: StoreOf<CompositionRoot>!

    init() {
        store = Store(
            initialState: AppState(),
            reducer: CompositionRoot()
                .dependency(\.appLifeCycle.stream, {
                    @Sendable [stream = delegate.stream] in stream
                })
                .signpost("MarvelAtThisSignpost")
                ._printChanges()
        )
        ViewStore(self.store).send(.bootstrap)
    }

    var body: some Scene {
        WindowGroup {
            RootView(store: store)
        }
    }
}
