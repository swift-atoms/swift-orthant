import Direction
import Finite
import Ordinal
import Orthant

extension Orthant: Finite.Enumerable {

    @inlinable
    public static var count: Cardinal { Cardinal(integerLiteral: UInt(1) << UInt(N)) }

    @inlinable
    public var ordinal: Ordinal {
        var bits: UInt = 0
        for index in 0..<N where directions[index] == .negative {
            bits |= (UInt(1) << UInt(index))
        }
        return Ordinal(bits)
    }

    @inlinable
    public init(_unchecked: Void, ordinal: Ordinal) {
        let bits = ordinal.rawValue
        self.init(
            InlineArray<N, Direction> { index in
                (bits & (UInt(1) << UInt(index))) != 0 ? .negative : .positive
            }
        )
    }
}
