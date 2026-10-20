public import Cardinal
public import Direction
public import Ordinal

extension Orthant {
    @inlinable
    public static var count: Cardinal {
        get throws(Error) {
            guard N >= 0, N < UInt.bitWidth else { throw .countOverflow }
            return Cardinal(UInt(1) << N)
        }
    }

    @inlinable
    public var ordinal: Ordinal {
        get throws(Error) {
            var bits: UInt = 0
            for index in 0..<N where directions[index] == .negative {
                guard index < UInt.bitWidth else { throw .ordinalOverflow }
                bits |= UInt(1) << index
            }
            return Ordinal(bits)
        }
    }

    @inlinable
    public init(ordinal: Ordinal) throws(Error) {
        if N < UInt.bitWidth {
            guard ordinal.rawValue < UInt(1) << N else {
                throw .ordinalOutOfBounds(ordinal)
            }
        }
        self.init(_ordinal: ordinal)
    }

    @usableFromInline
    init(_ordinal: Ordinal) {
        let bits = _ordinal.rawValue
        self.init(
            InlineArray<N, Direction> { index in
                index < UInt.bitWidth && bits & (UInt(1) << index) != 0 ? .negative : .positive
            }
        )
    }
}
