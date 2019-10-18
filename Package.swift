// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "OpenBreweryKit",
    products: [
        .library(
            name: "OpenBreweryKit",
            targets: ["OpenBreweryKit"])
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "OpenBreweryKit",
            dependencies: []),
        .testTarget(
            name: "OpenBreweryKitTests",
            dependencies: ["OpenBreweryKit"])
    ]
)
