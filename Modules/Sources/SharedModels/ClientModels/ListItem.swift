//
// Created by Dave Ingle
// Copyright © 2022 Dialpad Inc. All rights reserved.
//

import Foundation

public struct ListItem<A>: Identifiable where A: Identifiable {
    public let id: A.ID

    public let thumbnail: ImageRef
    public let summary: Summary
    public var content: A?
}

public typealias MarvelCharacterListItem = ListItem<MarvelCharacter>
public typealias CosmicEventListItem = ListItem<CosmicEvent>
