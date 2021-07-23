// swift-tools-version:5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PlaceholderKit",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .watchOS(.v6),
        .tvOS(.v13)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "PlaceholderKit",
            targets: ["PlaceholderKit"]),
    ],
    dependencies: [
        .package(name: "MGNetworking", url: "https://github.com/mgacy/MGNetworking.git", from: "1.0.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "PlaceholderKit",
            dependencies: ["MGNetworking"]),
        .testTarget(
            name: "PlaceholderKitTests",
            dependencies: ["PlaceholderKit"]),
    ]
)
