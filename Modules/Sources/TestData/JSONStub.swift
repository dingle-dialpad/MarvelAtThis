//
// Created by Dave Ingle
// Copyright © 2022 Dialpad Inc. All rights reserved.
//

import Foundation

public enum JSONStub: String {
    case getCharacters200 = "get_characters_200"

    public var data: Data {
        let fileURL = URL(fileURLWithPath: path)
        let data: Data! = try? Data(contentsOf: fileURL)
        precondition(data != nil, "\(Self.self) Failed to read data from file \(rawValue).json")
        return data
    }
}

extension JSONStub {
    var path: String {
        let path: String! = Bundle.module.path(
            forResource: rawValue,
            ofType: "json",
            inDirectory: "Payloads"
        )
        precondition(path != nil, "\(Self.self) Failed to find path for resource \(rawValue).json")
        return path
    }
}

