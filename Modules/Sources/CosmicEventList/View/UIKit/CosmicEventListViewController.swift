//
// Created by Dave Ingle
// Copyright © 2022 Dialpad Inc. All rights reserved.
//

import Combine
import ComposableArchitecture
import SharedModels
import UIKit

final class CosmicEventListViewController: UICollectionViewController {
    enum CosmicEventCategory {
        case all
    }

    typealias CellRegistration = UICollectionView.CellRegistration<UICollectionViewCell, CosmicEvent>
    typealias DataSource = UICollectionViewDiffableDataSource<CosmicEventCategory, CosmicEvent.ID>

    let store: StoreOf<CosmicEventList>
    let viewStore: ViewStoreOf<CosmicEventList>

    private var dataSource: DataSource!
    private var cancellables: Set<AnyCancellable> = []

    init(store: StoreOf<CosmicEventList>) {
        self.store = store
        self.viewStore = ViewStore(self.store)
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
                item: viewStore.events[id: identifier]!
            )
        }
    }

    func connectViewStore() {
        precondition(dataSource != nil, "DataSource must be configured before connecting viewStore")

        viewStore.publisher.events
            .sink(receiveValue: { [weak dataSource] events in
                var snapshot = NSDiffableDataSourceSnapshot<CosmicEventCategory, CosmicEvent.ID>()
                snapshot.appendSections([.all])
                snapshot.appendItems(Array(events.ids), toSection: .all)
                dataSource?.apply(snapshot, animatingDifferences: true)
            })
            .store(in: &self.cancellables)
    }

    private static let cellRegistration = CellRegistration { cell, indexPath, event in
            var configuration = UIListContentConfiguration.subtitleCell()
            configuration.text = event.title
            configuration.secondaryText = event.summary
            configuration.image = UIImage(systemName: "trash.fill")
            configuration.imageProperties.cornerRadius = 30
            configuration.imageProperties.maximumSize = CGSize(width: 60, height: 60)
            cell.contentConfiguration = configuration
    }
}


import SwiftUI
struct CosmicEventListViewController_Previews: PreviewProvider {
    static var previews: some View {
        let store = Store(
            initialState: CosmicEventList.State(
                events: .mock
            ),
            reducer: CosmicEventList()
        )

        return CosmicEventList.UIKit(store: store)
    }
}


