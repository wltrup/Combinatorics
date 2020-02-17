// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Combinatorics",
    products: [
        .library(
            name: "Combinatorics",
            targets: ["Combinatorics"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Combinatorics",
            dependencies: []),
        .testTarget(
            name: "CombinatoricsTests",
            dependencies: ["Combinatorics"]),
    ]
)
