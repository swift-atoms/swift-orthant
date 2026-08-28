import Direction_Primitive

public struct Orthant<let N: Int>: Sendable {

    public let directions: InlineArray<N, Direction>

    @inlinable
    public init(_ directions: InlineArray<N, Direction>) {
        self.directions = directions
    }
}

extension Orthant {

    @inlinable
    public init(repeating direction: Direction) {
        self.init(InlineArray<N, Direction>(repeating: direction))
    }

    @inlinable
    public init(_ direction: (Int) -> Direction) {
        self.init(InlineArray<N, Direction> { index in direction(index) })
    }
}

extension Orthant {

    @inlinable
    public var opposite: Orthant {
        Orthant(InlineArray<N, Direction> { index in directions[index].opposite })
    }
}

extension Orthant {

    @inlinable
    public static func == (lhs: Orthant, rhs: Orthant) -> Bool {
        for index in 0..<N where lhs.directions[index] != rhs.directions[index] { return false }
        return true
    }

    @inlinable
    public static func < (lhs: Orthant, rhs: Orthant) -> Bool {
        for index in 0..<N where lhs.directions[index] != rhs.directions[index] {
            return lhs.directions[index] < rhs.directions[index]
        }
        return false
    }

    @inlinable
    public static func <= (lhs: Orthant, rhs: Orthant) -> Bool { !(rhs < lhs) }

    @inlinable
    public static func > (lhs: Orthant, rhs: Orthant) -> Bool { rhs < lhs }

    @inlinable
    public static func >= (lhs: Orthant, rhs: Orthant) -> Bool { !(lhs < rhs) }

    @inlinable
    public func hash(into hasher: inout Hasher) {
        (0..<N).forEach { index in hasher.combine(directions[index].sign) }
    }
}

#if !hasFeature(Embedded)
    extension Orthant: Codable {

        @inlinable
        public init(from decoder: any Decoder) throws {
            var container = try decoder.unkeyedContainer()
            self.init(try InlineArray<N, Direction> { _ in try container.decode(Direction.self) })
        }

        @inlinable
        public func encode(to encoder: any Encoder) throws {
            var container = encoder.unkeyedContainer()
            for index in 0..<N { try container.encode(directions[index]) }
        }
    }
#endif
