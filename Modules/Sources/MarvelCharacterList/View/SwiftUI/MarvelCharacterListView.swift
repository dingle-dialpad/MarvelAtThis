//
// Created by Dave Ingle
// Copyright © 2022 Dialpad Inc. All rights reserved.
//

import SwiftUI
import ComposableArchitecture
import SharedModels

struct MarvelCharacterListView: View {
    let store: StoreOf<MarvelCharacterList>
    @ObservedObject var viewStore: ViewStoreOf<MarvelCharacterList>

    public init(store: StoreOf<MarvelCharacterList>) {
        self.store = store
        self.viewStore = ViewStore(self.store)
    }

    var body: some View {
        List {
            ForEach(viewStore.characters, id: \.id) { character in
                HStack(alignment: .top) {
                    Image(systemName: "trash.fill")
                    VStack(alignment: .leading) {
                        Text(verbatim: character.name)
                        Text(verbatim: character.bio)
                    }
                }
                .onAppear {
                    viewStore.send(.characterDidAppear(character.id))
                }
                .fixedSize(horizontal: false, vertical: true)

            }
        }
        .listStyle(.plain)
        .toolbar {
            ToolbarItemGroup(placement: .principal) {
                characterOrderPicker
            }
        }.task {
            viewStore.send(.bootstrap)
        }
    }

    @ViewBuilder
    var favoriteBadge: some View {
        HStack(alignment: .firstTextBaseline) {
            Spacer()
            Text("3")
            Image(systemName: "star.fill")
        }
    }

    @ViewBuilder
    var characterOrderPicker: some View {
        Picker("", selection: self.viewStore.binding(
            get: \.sortOrder,
            send: MarvelCharacterList.Action.updateSortOrder
        )) {
            ForEach(MarvelCharacterList.OrderBy.allCases, id: \.self) { sortOrder in
                Text(sortOrder.rawValue).tag(sortOrder)
            }
        }.pickerStyle(.segmented)
    }
}

struct MarvelCharacterListView_Previews: PreviewProvider {

    static var previews: some View {
        NavigationView {
            MarvelCharacterListView(
                store: Store(
                    initialState: MarvelCharacterList.State(characters: .mock),
                    reducer: MarvelCharacterList()
                )
            )
        }
    }
}
