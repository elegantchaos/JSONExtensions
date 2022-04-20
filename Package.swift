// swift-tools-version:5.5

// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 20/04/2022.
//  All code (c) 2022 - present day, Sam Deane.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import PackageDescription

let package = Package(
    name: "JSONExtensions",
    platforms: [
        .macOS(.v12), .iOS(.v15), .tvOS(.v15), .watchOS(.v8)
    ],
    products: [
        .library(
            name: "JSONExtensions",
            targets: ["JSONExtensions"]),
    ],
    dependencies: [
        .package(url: "https://github.com/elegantchaos/XCTestExtensions.git", from: "1.4.2")
    ],
    targets: [
        .target(
            name: "JSONExtensions",
            dependencies: []),
        .testTarget(
            name: "JSONExtensionsTests",
            dependencies: ["JSONExtensions", "XCTestExtensions"]),
    ]
)
