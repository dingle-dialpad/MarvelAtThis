//
// Created by Dave Ingle
// Copyright © 2022 Dialpad Inc. All rights reserved.
//

import ComposableArchitecture
import SharedModels
import SwiftUI

extension CosmicEventList {
    struct RepresentableWrapper: UIViewControllerRepresentable {
        let viewController: UIViewController

        public init(viewController: UIViewController) {
            self.viewController = viewController
        }

        public func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
        public func makeUIViewController(context: Context) -> some UIViewController { viewController }
    }

    public static func UIKit(store: StoreOf<CosmicEventList>) -> some View {
        RepresentableWrapper(viewController: CosmicEventListViewController(store: store))
    }
}

extension CosmicEventList {
    public static func SwiftUI(store: StoreOf<CosmicEventList>) -> some View {
        CosmicEventListView(store: store)
    }
}


// MARK: - Placeholder Stuff

let placeholderURL = URL(string: "https://dialpadbeta.com")!

extension IdentifiedArray where Element == CosmicEvent, ID == CosmicEvent.ID {

    static let mock: Self = [
        CosmicEvent(
            id: 1,
            title: "t1",
            summary: "s1",
            canonicalURL: placeholderURL,
            urls: [],
            lastModified: .distantPast,
            thumbnail: ImageRef(path: "", fileExtension: ""),
            comics: ResourceList(
                available: 0,
                collectionURL: placeholderURL,
                items: [],
                returned: 0
            ),
            stories: .empty,
            series: .empty,
            characters: .empty,
            creators: .empty
        ),

        CosmicEvent(
            id: 2,
            title: "t2",
            summary: "s2",
            canonicalURL: placeholderURL,
            urls: [],
            lastModified: .distantPast,
            thumbnail: ImageRef(path: "", fileExtension: ""),
            comics: ResourceList(
                available: 0,
                collectionURL: placeholderURL,
                items: [],
                returned: 0
            ),
            stories: .empty,
            series: .empty,
            characters: .empty,
            creators: .empty
        )
    ]
}

extension ResourceList {

    static var empty: Self {
        .init(available: 0, collectionURL: placeholderURL, items: [], returned: 0)
    }
}
