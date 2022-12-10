//
// Created by Dave Ingle
// Copyright © 2022 Dialpad Inc. All rights reserved.
//

import XCTest

import APIClient

import SharedModels
import SnapshotTesting
import TestData

final class ModelDecodingTests: XCTestCase {

    func test_decodingResponseSchema() throws {
        let data = JSONStub.responseSchema.data

        let payload = try APIClient.decoder.decode(APIPayload<String>.self, from: data)
        assertSnapshot(matching: payload, as: .plist)
    }

    func test_decodingCharacters() throws {
        let data = JSONStub.getCharacters200.data

        let payload = try APIClient.decoder.decode(APIPayload<MarvelCharacter>.self, from: data)
        assertSnapshot(matching: payload, as: .plist)
    }
}

