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
        .package(url: "https://github.com/clerkinc/clerk-sdk-ios.git", from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "MyChatApp",
            dependencies: [
                .product(name: "PlaySDK", package: "PlaySDK"),
                .product(name: "ClerkSDK", package: "clerk-sdk-ios"),
                ],
            resources: [.copy("project.json")]
        ),
    ]
)
