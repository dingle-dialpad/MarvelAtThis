//
// Created by Dave Ingle
// Copyright © 2022 Dialpad Inc. All rights reserved.
//

import Foundation

struct ViewModel: Equatable {
    var isEmpty: Bool

    init(_ state: FavoriteList.State) {
        self.isEmpty = state.favorites.isEmpty
    }
}
