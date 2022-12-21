//
// Created by Dave Ingle
// Copyright © 2022 Dialpad Inc. All rights reserved.
//

import Foundation
import SharedModels
import ComposableArchitecture

extension DependencyValues {
    public var persistenceClient: PersistenceClient {
        get { self[PersistenceClient.self] }
        set { self[PersistenceClient.self] = newValue }
    }
}

public struct PersistenceClient {

    public var insertFavorite: @Sendable (_ characterID: MarvelCharacter.ID) async throws -> Void

    public init(insertFavorite: @Sendable @escaping (_: MarvelCharacter.ID) -> Void) {
        self.insertFavorite = insertFavorite
    }
}
