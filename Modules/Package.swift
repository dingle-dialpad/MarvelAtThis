// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Modules",
    platforms: [.macOS(.v10_15), .iOS(.v15)],
    products: [
        .library(name: "APIClient", targets: ["APIClient"]),
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
            dependencies: [.tca, "Rebar", "SharedModels"]
        ),
        .target(name: "Rebar"),
        .target(
            name: "SharedModels",
            dependencies: []
        ),
        .target(
            name: "TestData",
            dependencies: [],
            resources: [.copy("Payloads")]
        ),
        .testTarget(
            name: "APIClientTests",
            dependencies: ["APIClient", "TestData", .snapshotTesting],
            resources: [.process("__Snapshots__")]
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
