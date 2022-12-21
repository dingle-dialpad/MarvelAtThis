//
// Created by Dave Ingle
// Copyright © 2022 Dialpad Inc. All rights reserved.
//

import ComposableArchitecture
import SharedModels
import SwiftUI

extension FavoriteList {
    struct RepresentableWrapper: UIViewControllerRepresentable {
        let viewController: UIViewController

        public init(viewController: UIViewController) {
            self.viewController = viewController
        }

        public func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
        public func makeUIViewController(context: Context) -> some UIViewController { viewController }
    }

    public static func UIKit(store: StoreOf<FavoriteList>) -> some View {
        RepresentableWrapper(viewController: FavoriteListViewController(store: store))
    }
}

extension FavoriteList {
    public static func SwiftUI(store: StoreOf<FavoriteList>) -> some View {
        FavoriteListView(store: store)
    }
}
