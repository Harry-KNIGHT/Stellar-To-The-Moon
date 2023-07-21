// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Stellar-To-The-Moon",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Stellar-To-The-Moon",
            targets: ["Stellar-To-The-Moon"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Stellar-To-The-Moon"),
        .testTarget(
            name: "Stellar-To-The-MoonTests",
            dependencies: ["Stellar-To-The-Moon"]),
    ]
)
