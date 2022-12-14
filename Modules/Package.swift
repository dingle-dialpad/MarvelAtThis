// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Modules",
    platforms: [.macOS(.v10_15), .iOS(.v15)],
    products: [
        .library(name: "APIClient", targets: ["APIClient"]),
        .library(name: "CosmicEventList", targets: ["CosmicEventList"]),
        .library(name: "FavoritesFeature", targets: ["FavoritesFeature"]),
        .library(name: "MarvelCharacterList", targets: ["MarvelCharacterList"]),
        .library(name: "MarvelCharacterDetails", targets: ["MarvelCharacterDetails"]),
        .library(name: "MarvelData", targets: ["MarvelData"]),
        .library(name: "Rebar", targets: ["Rebar"]),
        .library(name: "SharedModels", targets: ["SharedModels"]),
        .library(name: "TestData", targets: ["TestData"])
    ],
    dependencies: [
        .package(
            url: "https://github.com/pointfreeco/swift-composable-architecture.git",
            from: Version("0.47.2")
        ),
        .package(
            url: "https://github.com/pointfreeco/swift-snapshot-testing.git",
            from: Version("1.10.0")
        )
    ],
    targets: [
        .target(
            name: "APIClient",
            dependencies: ["Rebar", "SharedModels"]
        ),
        .target(
            name: "CosmicEventList",
            dependencies: [.tca, "MarvelData"]
        ),
        .target(
            name: "FavoritesFeature",
            dependencies: [.tca, "MarvelData"]
        ),
        .target(
            name: "MarvelCharacterDetails",
            dependencies: [.tca, "MarvelData"]
        ),
        .target(
            name: "MarvelCharacterList",
            dependencies: [.tca, "MarvelData"]
        ),
        .target(
            name: "MarvelData",
            dependencies: [.tca, "SharedModels"]
        ),
        .target(name: "Rebar"),
        .target(name: "SharedModels"),
        .target(name: "TestData", resources: [.copy("Payloads")]),
        
        .testTarget(
            name: "APIClientTests",
            dependencies: ["APIClient", "TestData", .snapshotTesting],
            resources: [.process("__Snapshots__")]
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
    static let tca = Target.Dependency.product(name: "ComposableArchitecture", package: "swift-composable-architecture")
    static let snapshotTesting = Target.Dependency.product(name: "SnapshotTesting", package: "swift-snapshot-testing")
}
