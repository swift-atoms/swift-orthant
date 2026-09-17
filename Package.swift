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
        .library(name: "Orthant", targets: ["Orthant"]),

        .library(name: "Orthant Foundation Integration", targets: ["Orthant Foundation Integration"]),
        .library(name: "Orthant Test Support", targets: ["Orthant Test Support"]),
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
            url: "https://github.com/swift-atoms/swift-ordinal.git",
            branch: "main"
        ),
    ],
    targets: [
        .target(
            name: "Orthant",
            dependencies: [
                .product(name: "Direction", package: "swift-direction"),
                .product(name: "Cardinal", package: "swift-cardinal"),
                .product(name: "Ordinal", package: "swift-ordinal"),
            ],
            path: "Sources/Orthant"
        ),
        
        .target(
            name: "Orthant Foundation Integration",
            dependencies: [
                .target(name: "Orthant"),
            ],
            path: "Sources/Orthant Foundation Integration"
        ),
        .target(
            name: "Orthant Test Support",
            dependencies: [
                .target(name: "Orthant"),
                .product(name: "Ordinal", package: "swift-ordinal"),
            ],
            path: "Tests/Support"
        ),
        .testTarget(
            name: "Orthant Tests",
            dependencies: [
                .target(name: "Orthant"),
                .target(name: "Orthant Test Support"),
                .target(name: "Orthant Foundation Integration"),
            ],
            path: "Tests/Orthant Tests"
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets {
    target.swiftSettings = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("Lifetimes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
    ]
}
