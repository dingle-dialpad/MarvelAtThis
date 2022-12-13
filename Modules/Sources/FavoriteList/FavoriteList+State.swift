//
// Created by Dave Ingle
// Copyright © 2022 Dialpad Inc. All rights reserved.
//

import ComposableArchitecture
import Foundation
import SharedModels

extension FavoriteList {

    public struct State: Equatable {
        var characters: IdentifiedArrayOf<ListItem> = []
    }
}

extension FavoriteList {

    public struct ListItem: Equatable, Identifiable, Sendable {
        public var id: Int
        public var thumbnailURL: URL
        public var title: String
        public var body: String
        public var isFavorite: Bool
        public var storyCount: Int
        public var lastModified: Date

        public init(id: Int, thumbnailURL: URL, title: String, body: String, isFavorite: Bool, storyCount: Int, lastModified: Date) {
            self.id = id
            self.thumbnailURL = thumbnailURL
            self.title = title
            self.body = body
            self.isFavorite = isFavorite
            self.storyCount = storyCount
            self.lastModified = lastModified
        }
    }
}
