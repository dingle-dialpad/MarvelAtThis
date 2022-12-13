//
// Created by Dave Ingle
// Copyright © 2022 Dialpad Inc. All rights reserved.
//

import ComposableArchitecture
import Foundation
import MarvelData
import XCTestDynamicOverlay

public struct CosmicEventList: ReducerProtocol {

    @Dependency(\.marvelDataClient) var dataClient

    public func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .bootstrap: return .none
        }
    }

}

extension CosmicEventList {

    public enum Action: Equatable {
        case bootstrap
    }
}
