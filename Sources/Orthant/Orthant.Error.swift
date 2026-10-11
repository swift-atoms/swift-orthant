public import Ordinal

extension Orthant {
    public enum Error: Swift::Error, Hashable, Sendable {
        case countOverflow
        case ordinalOverflow
        case ordinalOutOfBounds(Ordinal)
    }
}
