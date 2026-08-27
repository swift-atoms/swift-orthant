// swift-tools-version: 6.4
import PackageDescription

let package = Package(
    name: "swift-orthant",
    platforms: [
        .macOS(.v27),
        .iOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
        .visionOS(.v27),
    ],
    products: [
        .library(
            name: "Orthant",
            targets: ["Orthant"]
        ),
        .library(
            name: "Orthant Standard Library Integration",
            targets: ["Orthant Standard Library Integration"]
        ),
        .library(
            name: "Orthant Apple Foundation Integration",
            targets: ["Orthant Apple Foundation Integration"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/swift-atoms/swift-direction.git",
            branch: "main"
        )
    ],
    targets: [
        .target(
            name: "Orthant",
            dependencies: [
                .product(name: "Direction", package: "swift-direction")
            ]
        ),
        .target(
            name: "Orthant Standard Library Integration",
            dependencies: [
                "Orthant",
                .product(name: "Direction", package: "swift-direction"),
                .product(
                    name: "Direction Standard Library Integration",
                    package: "swift-direction"
                ),
            ]
        ),
        .target(
            name: "Orthant Apple Foundation Integration",
            dependencies: [
                "Orthant",
                "Orthant Standard Library Integration",
            ]
        ),
        .testTarget(
            name: "Orthant Tests",
            dependencies: ["Orthant"]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("Lifetimes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
    ]

    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
