//
// Created by Dave Ingle
// Copyright © 2022 Dialpad Inc. All rights reserved.
//

import Foundation

extension ImageRef {

    static let mock = ImageRef(
        path: "",
        fileExtension: ""
    )
}

extension MarvelCharacter {

    static let mock = { (id: Int) -> MarvelCharacter in
        MarvelCharacter(
            id: id,
            name: "Name",
            bio: "Bio",
            lastModified: Date.distantPast,
            canonicalURL: .stub,
            urls: [],
            thumbnail: .mock,
            comics: .mock,
            stories: .mock,
            events: .mock,
            series: .mock
        )
    }

}

extension ResourceList {

    static var mock: ResourceList {
        ResourceList(
            available: 0,
            collectionURL: .stub,
            items: [],
            returned: 0
        )
    }
}

extension URL {
    static let stub = URL(string: "https://dialpadbeta.com")!
}
