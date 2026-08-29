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
            name: "Orthant Equation",
            targets: ["Orthant Equation"]
        ),
        .library(
            name: "Orthant Hash",
            targets: ["Orthant Hash"]
        ),
        .library(
            name: "Orthant Comparison",
            targets: ["Orthant Comparison"]
        ),
        .library(
            name: "Orthant Enumerable",
            targets: ["Orthant Enumerable"]
        ),

        .library(
            name: "Orthant",
            targets: ["Orthant"]
        ),

        .library(
            name: "Orthant Test Support",
            targets: ["Orthant Test Support"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/swift-atoms/swift-direction.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-cardinal.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-equation.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-hash.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-comparison.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-finite.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-ordinal.git",
            branch: "main"
        ),
    ],
    targets: [

        .target(
            name: "Orthant",
            dependencies: [
                .product(name: "Direction", package: "swift-direction")
            ]
        ),

        .target(
            name: "Orthant Equation",
            dependencies: [
                .target(name: "Orthant"),
                .product(name: "Equation Protocol", package: "swift-equation"),
            ]
        ),
        .target(
            name: "Orthant Hash",
            dependencies: [
                .target(name: "Orthant"),
                .product(name: "Hash Protocol", package: "swift-hash"),
            ]
        ),
        .target(
            name: "Orthant Comparison",
            dependencies: [
                .target(name: "Orthant"),
                .product(name: "Comparison Protocol", package: "swift-comparison"),
            ]
        ),

        .target(
            name: "Orthant Enumerable",
            dependencies: [
                .target(name: "Orthant"),
                .product(name: "Cardinal", package: "swift-cardinal"),
                .product(name: "Direction", package: "swift-direction"),
                .product(name: "Finite", package: "swift-finite"),
                .product(name: "Finite Enumerable", package: "swift-finite"),
                .product(name: "Ordinal", package: "swift-ordinal"),
            ]
        ),

        .target(
            name: "Orthant Test Support",
            dependencies: [
                .target(name: "Orthant"),
                .product(
                    name: "Ordinal Test Support",
                    package: "swift-ordinal"
                ),
            ],
            path: "Tests/Support"
        ),

        .testTarget(
            name: "Orthant Tests",
            dependencies: [
                .target(name: "Orthant"),
                .target(name: "Orthant Comparison"),
                .target(name: "Orthant Enumerable"),
                .target(name: "Orthant Equation"),
                .target(name: "Orthant Hash"),
                .target(name: "Orthant Test Support"),
            ]
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
