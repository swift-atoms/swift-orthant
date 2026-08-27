import Direction
import Orthant
import Testing

@Suite
struct `Orthant - Construction` {
    @Suite struct Unit {}
    @Suite struct `Edge Case` {}
    @Suite struct Integration {}
}

extension `Orthant - Construction`.Unit {
    @Test
    func `repeating sets every axis`() {
        let orthant = Orthant<3>(repeating: .positive)
        #expect(orthant.directions[0] == .positive)
        #expect(orthant.directions[1] == .positive)
        #expect(orthant.directions[2] == .positive)
    }

    @Test
    func `per-axis closure init`() {
        let orthant = Orthant<3> { index in index == 1 ? .negative : .positive }
        #expect(orthant.directions[0] == .positive)
        #expect(orthant.directions[1] == .negative)
        #expect(orthant.directions[2] == .positive)
    }
}

@Suite
struct `Orthant - Opposite` {
    @Suite struct Unit {}
    @Suite struct `Edge Case` {}
    @Suite struct Integration {}
}

extension `Orthant - Opposite`.Unit {
    @Test
    func `opposite flips every axis`() {
        let orthant = Orthant<3> { index in index == 0 ? .positive : .negative }
        let antipode = orthant.opposite
        #expect(antipode.directions[0] == .negative)
        #expect(antipode.directions[1] == .positive)
        #expect(antipode.directions[2] == .positive)
    }
}

extension `Orthant - Opposite`.`Edge Case` {
    @Test
    func `opposite is involution`() {
        let orthant = Orthant<2> { index in index == 0 ? .positive : .negative }
        #expect(orthant.opposite.opposite == orthant)
    }
}

@Suite
struct `Orthant - Conformances` {
    @Suite struct Unit {}
    @Suite struct `Edge Case` {}
    @Suite struct Integration {}
}

extension `Orthant - Conformances`.Unit {
    @Test
    func `Equatable is element-wise`() {
        #expect(Orthant<2>(repeating: .positive) == Orthant<2>(repeating: .positive))
        #expect(Orthant<2>(repeating: .positive) != Orthant<2>(repeating: .negative))
        #expect(
            Orthant<2> { $0 == 0 ? .positive : .negative }
                != Orthant<2> { $0 == 0 ? .negative : .positive }
        )
    }

    @Test
    func `Hashable distinguishes the four 2D orthants`() {
        let set: Set<Orthant<2>> = [
            Orthant<2>(repeating: .positive),
            Orthant<2> { $0 == 0 ? .positive : .negative },
            Orthant<2> { $0 == 0 ? .negative : .positive },
            Orthant<2>(repeating: .negative),
            Orthant<2>(repeating: .positive),
        ]
        #expect(set.count == 4)
    }
}

@Suite
struct `Orthant - Comparison` {
    @Suite struct Unit {}
    @Suite struct `Edge Case` {}
    @Suite struct Integration {}
}

extension `Orthant - Comparison`.Unit {
    @Test
    func `lexicographic order, axis 0 most significant`() {
        let mm = Orthant<2>(repeating: .negative)
        let mp = Orthant<2> { $0 == 0 ? .negative : .positive }
        let pm = Orthant<2> { $0 == 0 ? .positive : .negative }
        #expect(mm < mp)
        #expect(mp < pm)
        #expect(mm < pm)
        #expect(pm > mm)
    }
}
