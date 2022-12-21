//
// Created by Dave Ingle
// Copyright © 2022 Dialpad Inc. All rights reserved.
//

import UIKit
import Combine
import ComposableArchitecture

final class FavoriteListViewController: UICollectionViewController {
    typealias CellRegistration = UICollectionView.CellRegistration<UICollectionViewCell, FavoriteItem.State>
    typealias DataSource = UICollectionViewDiffableDataSource<Int, FavoriteItem.State.ID>

    let store: StoreOf<FavoriteList>
    let viewStore: ViewStore<ViewModel, FavoriteList.Action>

    private var dataSource: DataSource!
    private var cancellables: Set<AnyCancellable> = []

    init(store: StoreOf<FavoriteList>) {
        self.store = store
        self.viewStore = ViewStore(self.store.scope(state: ViewModel.init))
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            let configuration = UICollectionLayoutListConfiguration(appearance: .plain)
            let section = NSCollectionLayoutSection.list(using: configuration, layoutEnvironment: layoutEnvironment)
            return section
        }
        super.init(collectionViewLayout: layout)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureDataSource()
        connectViewStore()
    }

    func configureDataSource() {
        dataSource = DataSource(collectionView: collectionView) { [unowned viewStore] collectionView, indexPath, identifier in
            collectionView.dequeueConfiguredReusableCell(
                using: Self.cellRegistration,
                for: indexPath,
                item: viewStore.favorites[id: identifier]!
            )
        }
    }

    func connectViewStore() {
        precondition(dataSource != nil, "DataSource must be configured before connecting viewStore")

        viewStore.publisher.favorites
            .sink(receiveValue: { [weak dataSource] favorites in
                var snapshot = NSDiffableDataSourceSnapshot<Int, FavoriteItem.State.ID>()
                snapshot.appendSections([1])
                snapshot.appendItems(Array(favorites.ids), toSection: 1)
                dataSource?.apply(snapshot, animatingDifferences: true)
            })
            .store(in: &self.cancellables)
    }

    private static let cellRegistration = CellRegistration { cell, indexPath, favorite in
            var configuration = UIListContentConfiguration.subtitleCell()
            configuration.text = "text"
            configuration.secondaryText = "summary"
            configuration.image = UIImage(systemName: "trash.fill")
            configuration.imageProperties.cornerRadius = 30
            configuration.imageProperties.maximumSize = CGSize(width: 60, height: 60)
            cell.contentConfiguration = configuration
    }
}


import SwiftUI
struct FavoriteListViewController_Previews: PreviewProvider {

    static var previews: some View {
        NavigationView {
            FavoriteList.UIKit(
                store: Store(
                    initialState: FavoriteList.State(favorites: [
                        .init(itemID: 1),
                        .init(itemID: 2)
                    ]),
                    reducer: FavoriteList()
                )
            ).navigationTitle("Favorites")
        }
    }
}
