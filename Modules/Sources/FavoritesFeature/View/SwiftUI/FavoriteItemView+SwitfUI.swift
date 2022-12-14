//
// Created by Dave Ingle
// Copyright © 2022 Dialpad Inc. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

struct FavoriteItemView_SwiftUI: View {
    let store: StoreOf<FavoriteItem>
    @ObservedObject var viewStore: ViewStoreOf<FavoriteItem>

    init(store: StoreOf<FavoriteItem>) {
        self.store = store
        self.viewStore = ViewStore(self.store)
    }

    var body: some View {
        HStack {
            Rectangle().frame(width: 44, height: 44)
        }.padding(16)
    }
}


struct FavoriteItemView_SwiftUI_Previews: PreviewProvider {

    static var previews: some View {
        FavoriteItemView_SwiftUI(
            store: Store(
                initialState: FavoriteItem.State(itemID: 1),
                reducer: FavoriteItem()
            )
        )
    }
}
