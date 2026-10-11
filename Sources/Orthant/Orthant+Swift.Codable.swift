import Direction

#if !hasFeature(Embedded)
extension Orthant: Swift::Codable {
    @inlinable
    public init(from decoder: any Decoder) throws {
        var container = try decoder.unkeyedContainer()
        self.init(try InlineArray<N, Direction> { _ in try container.decode(Direction.self) })
        guard container.isAtEnd else {
            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "Expected exactly \(N) orthant directions"
            )
        }
    }

    @inlinable
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.unkeyedContainer()
        for index in 0..<N { try container.encode(directions[index]) }
    }
}
#endif
