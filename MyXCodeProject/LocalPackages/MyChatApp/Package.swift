// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MyChatApp",
    platforms: [
        .iOS(.v16),
        .macCatalyst(.v16),
    ],
    products: [
        .library(
            name: "MyChatApp",
            targets: ["MyChatApp"]),
    ],
    dependencies: [
        .package(url: "https://github.com/CreateWithPlayApp/PlaySDK.git", exact: "0.3.0-beta"),
    ],
    targets: [
        .target(
            name: "MyChatApp",
            dependencies: [
                .product(name: "PlaySDK", package: "PlaySDK"),
                ],
            resources: [.copy("project.json")]
        ),
    ]
)
