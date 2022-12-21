//
// Created by Dave Ingle
// Copyright © 2022 Dialpad Inc. All rights reserved.
//

import Foundation
import SharedModels

extension APIClient {

    public func fetchCharacters(cursor: Cursor?) async throws -> APIPayload<MarvelCharacter> {
        try await self.request(
            route: .characters(.fetchCharacters(cursor))
        )
    }

    public func fetchEvents(cursor: Cursor?) async throws -> APIPayload<CosmicEvent> {
        try await self.request(
            route: .events(.fetchEvents(cursor))
        )
    }
}
