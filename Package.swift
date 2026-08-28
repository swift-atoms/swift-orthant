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
            name: "Orthant Primitive",
            targets: ["Orthant Primitive"]
        ),

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
            url: "https://github.com/swift-molecules/swift-direction.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-equation.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-hash.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-comparison.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-finite.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-ordinal.git",
            branch: "main"
        ),
    ],
    targets: [

        .target(
            name: "Orthant Primitive",
            dependencies: [
                .product(name: "Direction Primitive", package: "swift-direction")
            ]
        ),

        .target(
            name: "Orthant Equation",
            dependencies: [
                "Orthant Primitive",
                .product(name: "Equation", package: "swift-equation"),
            ]
        ),
        .target(
            name: "Orthant Hash",
            dependencies: [
                "Orthant Primitive",
                .product(name: "Hash", package: "swift-hash"),
            ]
        ),
        .target(
            name: "Orthant Comparison",
            dependencies: [
                "Orthant Primitive",
                .product(name: "Comparison", package: "swift-comparison"),
            ]
        ),

        .target(
            name: "Orthant Enumerable",
            dependencies: [
                "Orthant Primitive",
                .product(name: "Direction Primitive", package: "swift-direction"),
                .product(name: "Finite", package: "swift-finite"),
                .product(name: "Ordinal", package: "swift-ordinal"),
            ]
        ),

        .target(
            name: "Orthant",
            dependencies: [
                "Orthant Primitive",
                "Orthant Equation",
                "Orthant Hash",
                "Orthant Comparison",
                "Orthant Enumerable",
            ]
        ),

        .target(
            name: "Orthant Test Support",
            dependencies: [
                "Orthant",
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
                "Orthant",
                "Orthant Test Support",
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
