public import Ordinal

extension Orthant.Enumeration.Iterator: Swift::IteratorProtocol {
    @inlinable
    public mutating func next() -> Orthant<N>? {
        guard current < end else { return nil }
        let orthant = Orthant<N>(_ordinal: Ordinal(current))
        current += 1
        return orthant
    }
}
