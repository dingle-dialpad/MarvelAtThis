//
// Created by Dave Ingle
// Copyright © 2022 Dialpad Inc. All rights reserved.
//

import UIKit

import Combine
import SharedModels
import ComposableArchitecture

public final class MarvelCharacterListViewController: UICollectionViewController {
    typealias CellRegistration = UICollectionView.CellRegistration<MarvelCharacterContentView, MarvelCharacter>
    typealias DataSource = UICollectionViewDiffableDataSource<Section, MarvelCharacter.ID>

    enum Section {
        case main
    }

    let refreshControl = UIRefreshControl()

    lazy var segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: MarvelCharacterList.OrderBy.allCases.map(\.rawValue))
        control.translatesAutoresizingMaskIntoConstraints = false
        control.selectedSegmentIndex = 0
        control.addTarget(self, action: #selector(onSegmentChanged), for: .valueChanged)
        return control
    }()

    var dataSource: UICollectionViewDiffableDataSource<Section, MarvelCharacter.ID>!
    let cellIdentifier = "cellIdentifier"

    let store: StoreOf<MarvelCharacterList>
    let viewStore: ViewStoreOf<MarvelCharacterList>

    var cancellables: Set<AnyCancellable> = []

    public init(store: StoreOf<MarvelCharacterList>) {
        self.store = store
        self.viewStore = ViewStore(self.store)
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            let configuration = UICollectionLayoutListConfiguration(appearance: .plain)
            let section = NSCollectionLayoutSection.list(using: configuration, layoutEnvironment: layoutEnvironment)
            return section
        }
        super.init(collectionViewLayout: layout)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        viewStore.send(.bootstrap)
    }

    private func setup() {
        title = "Characters"
        view.backgroundColor = .systemBackground
        configureDataSource()
        connectViewStore()
        setupRefereshControl()
        setupNavigationItem()
        setupSegmentedControl()
    }

    private func setupNavigationItem() {
        navigationController?.navigationBar.prefersLargeTitles = true
        //        navigationItem.rightBarButtonItems = [FavoritesButtonItem()]
    }

    private func setupRefereshControl() {
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        collectionView.addSubview(refreshControl)
    }

    @objc
    private func refresh() {
        //        Task {
        //            await viewModel.refresh()
        //            refreshControl.endRefreshing()
        //        }
    }

    private func setupSegmentedControl() {
        view.addSubview(segmentedControl)
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }

    private func configureDataSource() {
        let registration = Self.cellRegistration
        dataSource = DataSource(collectionView: collectionView) { [unowned viewStore] collectionView, indexPath, identifier in
            collectionView.dequeueConfiguredReusableCell(
                using: registration,
                for: indexPath,
                item: viewStore.characters[id: identifier]!
            )
        }
    }

    private func connectViewStore() {
        precondition(dataSource != nil, "DataSource must be configured before connecting viewStore")

        viewStore.publisher.characters
            .sink(receiveValue: { [weak dataSource] characters in
                var snapshot = NSDiffableDataSourceSnapshot<Section, MarvelCharacter.ID>()
                snapshot.appendSections([Section.main])
                snapshot.appendItems(Array(characters.ids), toSection: .main)
                dataSource?.apply(snapshot, animatingDifferences: true)
            })
            .store(in: &self.cancellables)
    }

    private static let cellRegistration = CellRegistration { cell, indexPath, character in
        cell.nameLabel.text = character.name
        cell.descriptionLabel.text = character.bio
        cell.storiesLabel.text = "\(character.stories.available) stories"
        cell.dateLabel.text = "\(character.lastModified)"
        //
        //        let imageString = character.thumbnail.url
        //        let url = URL(string: imageString)!
//        cell.thumbNailImageView.loadAsync(character.thumbnail.url)
    }

    @objc
    private func onSegmentChanged() {
        let index = segmentedControl.selectedSegmentIndex
        let selected = MarvelCharacterList.OrderBy.allCases[index]
        viewStore.send(.updateSortOrder(selected))
        scrollToTop()
    }

    private func scrollToTop() {
        collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
    }
}

extension MarvelCharacterListViewController: UITableViewDelegate {

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        fatalError()
//        let character = viewModel.characters[indexPath.row]
//        let viewModel = CharacterDetailViewModel(character: character)
//        let viewController = UINavigationController(rootViewController: CharacterDetailViewController(viewModel: viewModel))
//        self.present(viewController, animated: true)
    }

    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let activityIndicator: UIActivityIndicatorView = {
            let activityIndicator = UIActivityIndicatorView(style: .medium)
            activityIndicator.translatesAutoresizingMaskIntoConstraints = false
            activityIndicator.color = .black
            return activityIndicator
        }()

        let view = UIView()
        view.addSubview(activityIndicator)

        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        activityIndicator.startAnimating()
        return view
    }

    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }

    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        CGFloat.leastNormalMagnitude
    }

}

import SwiftUI
struct MarvelCharacterListViewController_Previews: PreviewProvider {

    static var previews: some View {
        NavigationView {
            MarvelCharacterList.UIKit(
                store: Store(
                    initialState: MarvelCharacterList.State(characters: .mock),
                    reducer: MarvelCharacterList()
                )
            ).navigationTitle("Characters")
        }
    }
}
