// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WWMicrophoneInput",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(name: "WWMicrophoneInput", targets: ["WWMicrophoneInput"]),
    ],
    targets: [
        .target(name: "WWMicrophoneInput", resources: [.copy("Privacy")]),
    ],
    swiftLanguageVersions: [
        .v5
    ]
)
