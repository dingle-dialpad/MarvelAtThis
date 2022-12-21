//
// Created by Dave Ingle
// Copyright © 2022 Dialpad Inc. All rights reserved.
//

import SwiftUI
import ComposableArchitecture
import SharedModels

struct CosmicEventListView: View {
    let store: StoreOf<CosmicEventList>
    @ObservedObject var viewStore: ViewStoreOf<CosmicEventList>

    public init(store: StoreOf<CosmicEventList>) {
        self.store = store
        self.viewStore = ViewStore(self.store)
    }

    var body: some View {
        List {
            ForEach(viewStore.events, id: \.id) { event in
                HStack(alignment: .top) {
                    Image(systemName: "trash.fill")
                    VStack(alignment: .leading) {
                        Text(verbatim: event.title)
                        Text(verbatim: event.summary)
                    }
                }.onAppear {
                    viewStore.send(.eventDidAppear(event.id))
                }
            }
        }
        .listStyle(.plain)
        .task {
            viewStore.send(.bootstrap)
        }
    }

}

struct CosmicEventListView_Previews: PreviewProvider {
    
    static var previews: some View {
        CosmicEventListView(
            store: Store(
                initialState: CosmicEventList.State(events: .mock),
                reducer: CosmicEventList()
            )
        )
    }
}
