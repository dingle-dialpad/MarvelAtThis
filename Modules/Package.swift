// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Modules",
    platforms: [.macOS(.v10_15), .iOS(.v15)],
    products: [
        .library(name: "APIClient", targets: ["APIClient"]),
        .library(name: "APIClientLive", targets: ["APIClientLive"]),
        .library(name: "AppDelegateClient", targets: ["AppDelegateClient"]),
        .library(name: "AppFeature", targets: ["AppFeature"]),
        .library(name: "AsyncImage", targets: ["AsyncImage"]),
        .library(name: "CosmicEventList", targets: ["CosmicEventList"]),
        .library(name: "FavoritesFeature", targets: ["FavoritesFeature"]),
        .library(name: "MarvelCharacterList", targets: ["MarvelCharacterList"]),
        .library(name: "MarvelCharacterDetails", targets: ["MarvelCharacterDetails"]),
        .library(name: "MarvelData", targets: ["MarvelData"]),
        .library(name: "PersistenceClient", targets: ["PersistenceClient"]),
        .library(name: "PersistenceClientLive", targets: ["PersistenceClientLive"]),
        .library(name: "RealtimeMessaging", targets: ["RealtimeMessaging"]),
        .library(name: "RealtimeMessagingLive", targets: ["RealtimeMessagingLive"]),
        .library(name: "Rebar", targets: ["Rebar"]),
        .library(name: "RemoteNotificationsClient", targets: ["RemoteNotificationsClient"]),
        .library(name: "SharedModels", targets: ["SharedModels"]),
        .library(name: "TestData", targets: ["TestData"]),
        .library(name: "UIComponents", targets: ["UIComponents"]),
        .library(name: "UserNotificationsClient", targets: ["UserNotificationsClient"])
    ],
    dependencies: [
        .package(
            url: "https://github.com/ably/ably-cocoa.git",
            from: Version("1.2.19")
        ),
        .package(
            url: "https://github.com/pointfreeco/swift-composable-architecture.git",
            from: Version("0.47.2")
        ),
        .package(
            url: "https://github.com/pointfreeco/swift-snapshot-testing.git",
            from: Version("1.10.0")
        ),
        .package(
            url: "https://github.com/onevcat/Kingfisher.git",
            from: Version("7.0.0")
        )
    ],
    targets: [
        .target(
            name: "APIClient",
            dependencies: [.tca, "Rebar", "SharedModels"]
        ),
        .target(
            name: "APIClientLive",
            dependencies: ["APIClient"]
        ),
        .target(
            name: "AppDelegateClient",
            dependencies: [.tca]
        ),
        .target(
            name: "AppFeature",
            dependencies: [
                .tca,
                "AppDelegateClient",
                "CosmicEventList",
                "FavoritesFeature",
                "MarvelCharacterList",
                "RealtimeMessaging",
                "RemoteNotificationsClient",
                "UserNotificationsClient",
            ]
        ),
        .target(
            name: "AsyncImage",
            dependencies: [.tca, .kingfisher]
        ),
        .target(
            name: "CosmicEventList",
            dependencies: [.tca, "APIClient"]
        ),
        .target(
            name: "FavoritesFeature",
            dependencies: [.tca, "APIClient"]
        ),
        .target(
            name: "MarvelCharacterDetails",
            dependencies: [.tca, "MarvelData"]
        ),
        .target(
            name: "MarvelCharacterList",
            dependencies: [.tca, "APIClient"]
        ),
        .target(
            name: "MarvelData",
            dependencies: [.tca, "SharedModels"]
        ),
        .target(
            name: "PersistenceClient",
            dependencies: [.tca, "SharedModels"]
        ),
        .target(
            name: "PersistenceClientLive",
            dependencies: ["PersistenceClient"],
            resources: [.copy("CoreDataModel")]
        ),
        .target(
            name: "RealtimeMessaging",
            dependencies: [.tca, "SharedModels"]
        ),
        .target(
            name: "RealtimeMessagingLive",
            dependencies: [.ably, "RealtimeMessaging"]
        ),
        .target(name: "Rebar"),
        .target(name: "RemoteNotificationsClient", dependencies: [.tca]),
        .target(name: "SharedModels"),
        .target(name: "TestData", resources: [.copy("Payloads")]),
        .target(name: "UIComponents", dependencies: ["AsyncImage"]),
        .target(name: "UserNotificationsClient", dependencies: [.tca]),
        
            .testTarget(
                name: "APIClientTests",
                dependencies: ["APIClient", "TestData", .snapshotTesting],
                resources: [.process("__Snapshots__")]
            ),
        .testTarget(
            name: "AppFeatureTests",
            dependencies: ["AppFeature"]
        ),
        .testTarget(
            name: "FavoritesFeatureTests",
            dependencies: ["FavoritesFeature"]
        ),
        .testTarget(
            name: "MarvelCharacterListTests",
            dependencies: ["MarvelCharacterList", "APIClient", "TestData"]
        ),
        .testTarget(
            name: "SharedModelsTests",
            dependencies: ["SharedModels"]
        ),
    ]
)

extension Target.Dependency {
    static let tca = Target.Dependency.product(
        name: "ComposableArchitecture",
        package: "swift-composable-architecture")
    
    static let snapshotTesting = Target.Dependency.product(
        name: "SnapshotTesting",
        package: "swift-snapshot-testing")
    
    static let ably = Target.Dependency.product(
        name: "Ably",
        package: "ably-cocoa"
    )
    static let kingfisher = Target.Dependency.product(
        name: "Kingfisher",
        package: "Kingfisher"
    )
}
