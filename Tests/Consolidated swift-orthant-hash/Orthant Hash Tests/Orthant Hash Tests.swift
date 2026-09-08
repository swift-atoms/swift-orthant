import Direction
import Hash
import Orthant
import Testing

@Suite
struct `Orthant Hash Integration` {

    @Test
    func `Orthant retains its native Hashable behavior`() {
        let positive = Orthant<2>(repeating: Direction.positive)
        let negative = Orthant<2>(repeating: Direction.negative)
        let values: Set<Orthant<2>> = [positive]

        #expect(values.contains(positive))
        #expect(!values.contains(negative))
    }

    @Test
    func `Orthant supplies Hash's domain-typed value`() {
        let orthant = Orthant<2> { $0 == 0 ? Direction.positive : Direction.negative }
        let first: Hash.Value = hash(orthant)
        let second: Hash.Value = hash(orthant)

        #expect(first == second)
    }
}

private func hash<T: Hash.`Protocol`>(_ value: borrowing T) -> Hash.Value {
    value.hashValue
}
