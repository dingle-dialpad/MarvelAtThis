//
// Created by Dave Ingle
// Copyright © 2022 Dialpad Inc. All rights reserved.
//

import XCTest

import APIClient

import SharedModels
import TestData

final class ModelDecodingTests: XCTestCase {

    func test_decodingResponseSchema() throws {
        let data = JSONStub.responseSchema.data

        let payload = try APIClient.decoder.decode(APIPayload<String>.self, from: data)
        XCTAssertEqual(payload.metadata.code, 200)
        XCTAssertEqual(payload.metadata.status, "Ok")
        XCTAssertEqual(payload.metadata.etag, "5616d2bbdfec4495120e3b473ac87ace37841048")
        XCTAssertEqual(payload.data.offset, 0)
        XCTAssertEqual(payload.data.limit, 20)
        XCTAssertEqual(payload.data.total, 1562)
        XCTAssertEqual(payload.data.count, 20)
        XCTAssertEqual(payload.data.results, [])
    }

}

