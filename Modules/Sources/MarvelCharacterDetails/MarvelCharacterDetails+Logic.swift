//
// Created by Dave Ingle
// Copyright © 2022 Dialpad Inc. All rights reserved.
//

import Foundation
import ComposableArchitecture
import XCTestDynamicOverlay
import MarvelData

public struct MarvelCharacterDetails: ReducerProtocol {

    @Dependency(\.marvelDataClient) var dataClient

    public func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .bootstrap: return .none
        }
    }

}

extension MarvelCharacterDetails {

    public enum Action: Equatable {
        case bootstrap
    }
}
