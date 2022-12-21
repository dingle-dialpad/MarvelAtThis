//
// Created by Dave Ingle
// Copyright © 2022 Dialpad Inc. All rights reserved.
//

import UIKit
import ComposableArchitecture
import AppDelegateClient
import UserNotificationsClient
import RealtimeMessaging
import MarvelCharacterList
import CosmicEventList
import FavoritesFeature
import SharedModels

public struct CompositionRoot: ReducerProtocol {
    public typealias State = AppState
    public typealias Action = AppAction

    @Dependency(\.appLifeCycle) var lifeCycle
    @Dependency(\.userNotifications) var userNotifications
    @Dependency(\.realtimeMessagingClient) var realtimeMessagingClient

    public init() { }

    @ReducerBuilder<State, Action>
    public var body: some ReducerProtocol<State, Action> {
        Scope(state: \.settings, action: /.self) {
            AppDelegateLogic()
        }

        Scope(state: \.characters, action: /AppAction.marvelCharacters) {
            MarvelCharacterList()
        }
        
        Scope(state: \.events, action: /AppAction.cosmicEvents) {
            CosmicEventList()
        }

        Reduce { state, action in
            switch action {
            case .bootstrap:
                return connectToLifeCycleEvents()

            case .lifeCycle:
                return .none

            case .userNotifications:
                return .none

            case .realtimeMessaging:
                return .none

            case .characterMessage:
                state.count += 1
                return .none

            case .marvelCharacters:
                return .none

            case .cosmicEvents:
                return .none

            case .favorites:
                return .none

            case .selectTab(let tab):
                state.selectedTab = tab
                return .none
            }
        }
    }

    func connectToLifeCycleEvents() -> EffectTask<AppAction> {
        EffectTask.run { send in
            for await event in self.lifeCycle.stream() {
                await send(.lifeCycle(event))
            }
        }
    }

}

public struct AppState: Equatable {
    var selectedTab: Tab = .characters
    var settings = AppSettings()
    var count = 0

    var characters = MarvelCharacterList.State()
    var events = CosmicEventList.State()
    var favorites = FavoriteList.State()

    public init() {

    }

    public enum Tab: Equatable {
        case characters
        case events
        case favorites
    }
}

public enum AppAction: Equatable {
    case bootstrap

    case selectTab(AppState.Tab)

    case marvelCharacters(MarvelCharacterList.Action)
    case cosmicEvents(CosmicEventList.Action)
    case favorites(FavoriteList.Action)

    case lifeCycle(LifeCycleEvent)
    case userNotifications(TaskResult<Bool>)
    case realtimeMessaging(RealtimeMessagingClient.Action)
    case characterMessage(RealtimeMessagingClient.Message)
}
