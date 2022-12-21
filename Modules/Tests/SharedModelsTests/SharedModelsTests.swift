//
// Created by Dave Ingle
// Copyright © 2022 Dialpad Inc. All rights reserved.
//

import XCTest
@testable import SharedModels

final class SharedModelsTests: XCTestCase {

    func test_extractingIDFromResourceRef() throws {
        /*
         "name" : "Alicia Masters",
         "resourceURI" : "http:\/\/gateway.marvel.com\/v1\/public\/characters\/1009435"
         */
        let ref = ResourceRef<MarvelCharacter>(
            uri: "http://gateway.marvel.com/v1/public/characters/1009435",
            name: "Alicia Masters"
        )
        XCTAssertEqual(ref.id, 1009435)
    }
}
