//
// Created by Dave Ingle
// Copyright © 2022 Dialpad Inc. All rights reserved.
//

import XCTest

@testable import APIClient

import SharedModels
import SnapshotTesting
import TestData

final class ModelDecodingTests: XCTestCase {

    func test_decodingResponseSchema() throws {
        let data = JSONStub.responseSchema.data

        let payload = try APIClient.decoder.decode(APIPayload<String>.self, from: data)
        assertSnapshot(matching: payload, as: .json(APIClient.encoder))
    }

    func test_decodingCharacters() throws {
        let data = JSONStub.getCharacters200.data

        let payload = try APIClient.decoder.decode(APIPayload<MarvelCharacter>.self, from: data)

        XCTAssertEqual(payload.data.count, 20)
        assertSnapshot(matching: payload, as: .json(APIClient.encoder))
    }

    func test_decodingCharacter() throws {
        let data = JSONStub.getCharacter200.data

        let payload = try APIClient.decoder.decode(APIPayload<MarvelCharacter>.self, from: data)

        XCTAssertEqual(payload.data.count, 1)
        assertSnapshot(matching: payload, as: .json(APIClient.encoder))
    }

    func test_decodingCosmicEvents() throws {
        let data = JSONStub.getEvents200.data

        let payload = try APIClient.decoder.decode(APIPayload<CosmicEvent>.self, from: data)

        XCTAssertEqual(payload.data.count, 20)
        assertSnapshot(matching: payload, as: .json(APIClient.encoder))
    }

    func test_decodingStories() throws {
        let data = JSONStub.getStories200.data

        let payload = try APIClient.decoder.decode(APIPayload<Story>.self, from: data)

        XCTAssertEqual(payload.data.count, 20)
        assertSnapshot(matching: payload, as: .json(APIClient.encoder))
    }

}

