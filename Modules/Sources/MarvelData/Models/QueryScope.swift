//
// Created by Dave Ingle
// Copyright © 2022 Dialpad Inc. All rights reserved.
//

import Foundation

public struct QueryScope<Resource> {

    public func eraseToAnyQueryScope() -> AnyQueryScope {
        AnyQueryScope(
            resourceType: Resource.self
        )
    }
}

public struct AnyQueryScope {
    let resourceType: Any
}

public enum Resource {
    public enum MarvelCharacter {}
    public enum CosmicEvent {}
    public enum Favorite {}
}


public typealias MarvelCharacterQuery = QueryScope<Resource.MarvelCharacter>
public typealias CosmicEventQuery = QueryScope<Resource.CosmicEvent>
public typealias FavoriteQuery = QueryScope<Resource.Favorite>
