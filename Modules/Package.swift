// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Modules",
    products: [
        .library(name: "SharedModels", targets: ["SharedModels"]),
    ],
    dependencies: [

    ],
    targets: [
        .target(name: "SharedModels", dependencies: []),
        .testTarget(name: "SharedModelsTests", dependencies: ["SharedModels"]),
    ]
)
