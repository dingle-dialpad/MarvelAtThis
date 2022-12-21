//
// Created by Dave Ingle
// Copyright © 2022 Dialpad Inc. All rights reserved.
//

import ComposableArchitecture
import SharedModels
import SwiftUI

extension MarvelCharacterList {
    struct RepresentableWrapper: UIViewControllerRepresentable {
        let viewController: UIViewController

        public init(viewController: UIViewController) {
            self.viewController = viewController
        }

        public func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
        public func makeUIViewController(context: Context) -> some UIViewController { viewController }
    }

    public static func UIKit(store: StoreOf<MarvelCharacterList>) -> some View {
        RepresentableWrapper(viewController: MarvelCharacterListViewController(store: store))
    }
}

extension MarvelCharacterList {
    public static func SwiftUI(store: StoreOf<MarvelCharacterList>) -> some View {
        MarvelCharacterListView(store: store)
    }
}


// MARK: - Placeholder Stuff

let placeholderURL = URL(string: "https://dialpadbeta.com")!

extension IdentifiedArray where Element == MarvelCharacter, ID == MarvelCharacter.ID {

    static let mock: Self = [
        MarvelCharacter(
            id: 1,
            name: "n1",
            bio: "b1",
            lastModified: .distantPast,
            canonicalURL: placeholderURL,
            urls: [],
            thumbnail: ImageRef(path: "", fileExtension: ""),
            comics: .empty,
            stories: .empty,
            events: .empty,
            series: .empty
        ),
        MarvelCharacter(
            id: 2,
            name: "n2",
            bio: "b2",
            lastModified: .distantPast,
            canonicalURL: placeholderURL,
            urls: [],
            thumbnail: ImageRef(path: "", fileExtension: ""),
            comics: .empty,
            stories: .empty,
            events: .empty,
            series: .empty
        ),
    ]
}

extension ResourceList {

    static var empty: Self {
        .init(available: 0, collectionURL: placeholderURL, items: [], returned: 0)
    }
}
