//
// Created by Dave Ingle
// Copyright © 2022 Dialpad Inc. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

struct FavoriteListView: View {

    let store: StoreOf<FavoriteList>
    @ObservedObject var viewStore: ViewStore<ViewModel, FavoriteList.Action>

    public init(store: StoreOf<FavoriteList>) {
        self.store = store
        self.viewStore = ViewStore(self.store.scope(state: ViewModel.init))
    }

    var body: some View {
        List {
            ForEachStore(
                self.store.scope(
                    state: \.favorites,
                    action: FavoriteList.Action.favorite(id:action:)
                ),
                content: FavoriteItemView.init
            )
            .onDelete { self.viewStore.send(.delete($0)) }
            .onMove { self.viewStore.send(.move($0, $1)) }
        }.overlay {
            viewStore.isEmpty ? Text("no favorites") : nil
        }
    }

}

struct FavoriteListView_Previews: PreviewProvider {

    static var previews: some View {
        FavoriteListView(
            store: Store(
                initialState: .init(
                    favorites: [
                        .init(itemID: 1),
                        .init(itemID: 2),
                        .init(itemID: 3),
                        .init(itemID: 4)
                    ]),
                reducer: FavoriteList()
            )
        )
    }
}
