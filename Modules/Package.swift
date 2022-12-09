// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Modules",
    platforms: [.macOS(.v10_15), .iOS(.v15)],
    products: [
        .library(name: "APIClient", targets: ["APIClient"]),
        .library(name: "SharedModels", targets: ["SharedModels"]),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture.git", from: Version("0.47.2"))
    ],
    targets: [
        .target(name: "APIClient", dependencies: [.tca]),
        .target(name: "SharedModels", dependencies: []),
        .testTarget(name: "SharedModelsTests", dependencies: ["SharedModels"]),
    ]
)

extension Target.Dependency {
    static let tca: Target.Dependency = .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
}
