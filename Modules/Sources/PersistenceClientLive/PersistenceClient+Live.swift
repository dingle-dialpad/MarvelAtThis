//
// Created by Dave Ingle
// Copyright © 2022 Dialpad Inc. All rights reserved.
//

@_exported import PersistenceClient

import ComposableArchitecture
import Foundation
import CoreData


extension PersistenceClient: DependencyKey {

    public static var liveValue: PersistenceClient {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores { description, error in
            _ = error.flatMap { fatalError("Unable to load persistent stores: \($0)") }
        }
        container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        return PersistenceClient(
            insertFavorite: { characterID in
                let favorite = Favorite(context: container.newBackgroundContext())
                favorite.characterID = characterID
            }
        )
    }
}
