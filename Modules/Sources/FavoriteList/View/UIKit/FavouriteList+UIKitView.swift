//
// Created by Dave Ingle
// Copyright © 2022 Dialpad Inc. All rights reserved.
//

import UIKit

import ComposableArchitecture

final class FavoriteListViewController: UIViewController {
    let store: StoreOf<FavoriteList>
    let viewStore: ViewStore<ViewModel, FavoriteList.Action>

    init(store: StoreOf<FavoriteList>) {
        self.store = store
        self.viewStore = ViewStore(store.scope(state: ViewModel.init))
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        let view = UIView()
        self.view = view
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewStore.send(.bootstrap)
    }
}
