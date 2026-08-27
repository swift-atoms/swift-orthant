# Orthant

![Development Status](https://img.shields.io/badge/status-active--development-blue.svg)

An N-dimensional orthant for Swift — a per-axis `Direction` vector naming the `2ᴺ` quadrants, octants, and higher-dimensional sign regions of N-space.

---

## Quick Start

`Orthant<N>` assigns a `Direction` to every one of the `N` axes. It is the N-dimensional generalization of a quadrant (2D, 4 inhabitants) and an octant (3D, 8 inhabitants). The per-axis choices are stored in an `InlineArray<N, Direction>` indexed by `0..<N`.

```swift
import Direction
import Orthant

// A quadrant of the 2D plane is a sign choice on each of the two axes.
let quadrant = Orthant<2> { axis in axis == 0 ? .positive : .negative }   // (+x, −y)
quadrant.directions[0]   // .positive
quadrant.opposite        // (−x, +y) — every axis flipped
```

Orthants compare lexicographically, with axis 0 most significant:

```swift
import Direction
import Orthant

let mm = Orthant<2>(repeating: .negative)                 // (−, −)
let pm = Orthant<2> { $0 == 0 ? .positive : .negative }   // (+, −)
mm < pm                                                   // true
```

`Orthant` conforms directly to `Equatable`, `Hashable`, and `Comparable`.

---

## Installation

```swift
dependencies: [
    .package(url: "https://github.com/swift-atoms/swift-direction.git", branch: "main"),
    .package(url: "https://github.com/swift-atoms/swift-orthant.git", branch: "main")
]
```

```swift
.target(
    name: "App",
    dependencies: [
        .product(name: "Direction", package: "swift-direction"),
        .product(name: "Orthant", package: "swift-orthant"),
    ]
)
```

Requires Swift 6.4 and macOS 27 / iOS 27 / tvOS 27 / watchOS 27 / visionOS 27 (or the matching Linux / Windows toolchain).

---

## Architecture

The native `Orthant` target depends only on the `Direction` atom. Standard-library and Apple-Foundation integration stay in separate targets.

| Product | Target | Purpose |
|---------|--------|---------|
| `Orthant` | `Sources/Orthant/` | The Foundation-free value type, construction, opposite, equality, hashing, and ordering. |
| `Orthant Standard Library Integration` | `Sources/Orthant Standard Library Integration/` | `Codable` integration, compiled out for Swift Embedded. |
| `Orthant Apple Foundation Integration` | `Sources/Orthant Apple Foundation Integration/` | The Foundation-facing aggregation product. |

Foundation is imported only by the Apple Foundation Integration target.

---

## Platform Support

| Platform | Status |
|----------|--------|
| macOS 27 | Full support |
| Linux | Full support |
| Windows | Full support |
| iOS 27 / tvOS 27 / watchOS 27 / visionOS 27 | Supported |
| Swift Embedded | Native core supported; `Codable` is unavailable |

---

## Community

<!-- BEGIN: discussion -->
<!-- Discussion thread created at publication. -->
<!-- END: discussion -->

## License

Apache 2.0. See [LICENSE.md](LICENSE.md).
