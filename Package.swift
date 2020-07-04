// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "CircularCheckmarkProgress",
    platforms: [
        .iOS(.v14),
        .macOS(.v10_16),
        .watchOS(.v7),
        .tvOS(.v14),
    ],
    products: [
        .library(
            name: "CircularCheckmarkProgress",
            targets: ["CircularCheckmarkProgress"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "CircularCheckmarkProgress",
            dependencies: []),
    ]
)
