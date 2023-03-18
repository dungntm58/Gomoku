// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "Tools",
    dependencies: [
        .package(name: "Gomoku", path: ".."),
        .package(url: "https://github.com/apple/swift-docc-plugin", exact: "1.2.0"),
        .package(url: "https://github.com/apple/swift-format.git", exact: "0.50700.1"),
        .package(url: "https://github.com/yonaskolb/XcodeGen.git", exact: "2.34.0"),
    ]
)
