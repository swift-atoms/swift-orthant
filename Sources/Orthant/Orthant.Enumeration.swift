public import Cardinal
public import Ordinal

extension Orthant {
    public struct Enumeration: Sendable {
        public let count: Cardinal

        @usableFromInline
        init(count: Cardinal) {
            self.count = count
        }

        public struct Iterator: Sendable {
            @usableFromInline
            var current: UInt = 0

            @usableFromInline
            let end: UInt

            @usableFromInline
            init(end: UInt) {
                self.end = end
            }
        }
    }

    @inlinable
    public static var allCases: Enumeration {
        get throws(Error) {
            Enumeration(count: try count)
        }
    }
}

extension Orthant.Enumeration {

    @inlinable
    public func element(at ordinal: Ordinal) -> Orthant? {
        guard ordinal.rawValue < count.rawValue else { return nil }
        return Orthant(_ordinal: ordinal)
    }
}
