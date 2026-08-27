public import Direction
public import Direction_Standard_Library_Integration
public import Orthant

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
