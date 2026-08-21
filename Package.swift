// swift-tools-version: 6.4
import PackageDescription

let package = Package(
    name: "swift-orthant-primitives",
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
            name: "Orthant Equation Primitives",
            targets: ["Orthant Equation Primitives"]
        ),
        .library(
            name: "Orthant Hash Primitives",
            targets: ["Orthant Hash Primitives"]
        ),
        .library(
            name: "Orthant Comparison Primitives",
            targets: ["Orthant Comparison Primitives"]
        ),
        .library(
            name: "Orthant Enumerable Primitives",
            targets: ["Orthant Enumerable Primitives"]
        ),

        .library(
            name: "Orthant Primitives",
            targets: ["Orthant Primitives"]
        ),

        .library(
            name: "Orthant Primitives Test Support",
            targets: ["Orthant Primitives Test Support"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/swift-primitives/swift-direction-primitives.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-primitives/swift-equation-primitives.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-primitives/swift-hash-primitives.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-primitives/swift-comparison-primitives.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-primitives/swift-finite-primitives.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-primitives/swift-ordinal-primitives.git",
            branch: "main"
        ),
    ],
    targets: [

        .target(
            name: "Orthant Primitive",
            dependencies: [
                .product(name: "Direction Primitive", package: "swift-direction-primitives")
            ]
        ),

        .target(
            name: "Orthant Equation Primitives",
            dependencies: [
                "Orthant Primitive",
                .product(name: "Equation Primitives", package: "swift-equation-primitives"),
            ]
        ),
        .target(
            name: "Orthant Hash Primitives",
            dependencies: [
                "Orthant Primitive",
                .product(name: "Hash Primitives", package: "swift-hash-primitives"),
            ]
        ),
        .target(
            name: "Orthant Comparison Primitives",
            dependencies: [
                "Orthant Primitive",
                .product(name: "Comparison Primitives", package: "swift-comparison-primitives"),
            ]
        ),

        .target(
            name: "Orthant Enumerable Primitives",
            dependencies: [
                "Orthant Primitive",
                .product(name: "Direction Primitive", package: "swift-direction-primitives"),
                .product(name: "Finite Primitives", package: "swift-finite-primitives"),
                .product(name: "Ordinal Primitives", package: "swift-ordinal-primitives"),
            ]
        ),

        .target(
            name: "Orthant Primitives",
            dependencies: [
                "Orthant Primitive",
                "Orthant Equation Primitives",
                "Orthant Hash Primitives",
                "Orthant Comparison Primitives",
                "Orthant Enumerable Primitives",
            ]
        ),

        .target(
            name: "Orthant Primitives Test Support",
            dependencies: [
                "Orthant Primitives",
                .product(
                    name: "Ordinal Primitives Test Support",
                    package: "swift-ordinal-primitives"
                ),
            ],
            path: "Tests/Support"
        ),

        .testTarget(
            name: "Orthant Primitives Tests",
            dependencies: [
                "Orthant Primitives",
                "Orthant Primitives Test Support",
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
