//
// Created by Dave Ingle
// Copyright © 2022 Dialpad Inc. All rights reserved.
//

import Foundation
import ComposableArchitecture

struct ViewModel: Equatable {
    var isEmpty: Bool
    var favorites: IdentifiedArrayOf<FavoriteItem.State>

    init(_ state: FavoriteList.State) {
        self.isEmpty = state.favorites.isEmpty
        self.favorites = state.favorites
    }
}
