public import Cardinal

extension Orthant.Enumeration: Swift::Sequence {
    @inlinable
    public func makeIterator() -> Iterator {
        Iterator(end: count.rawValue)
    }
}
