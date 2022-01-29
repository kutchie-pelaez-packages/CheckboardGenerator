// swift-tools-version:5.3.0

import PackageDescription

let package = Package(
    name: "CheckboardGenerator",
    platforms: [
        .iOS("15")
    ],
    products: [
        .library(
            name: "CheckboardGenerator",
            targets: [
                "CheckboardGenerator"
            ]
        )
    ],
    dependencies: [
        .package(name: "Core", url: "https://github.com/kutchie-pelaez-packages/Core.git", .branch("master")),
        .package(name: "CoreUI", url: "https://github.com/kutchie-pelaez-packages/CoreUI.git", .branch("master"))
    ],
    targets: [
        .target(
            name: "CheckboardGenerator",
            dependencies: [
                .product(name: "Core", package: "Core"),
                .product(name: "CoreUI", package: "CoreUI")
            ],
            path: "Sources"
        )
    ]
)
