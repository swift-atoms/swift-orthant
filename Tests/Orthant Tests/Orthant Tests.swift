import Orthant
import Testing

@Suite
struct `Orthant construction assigns a direction to every axis` {
    @Suite struct `Orthants preserve repeated and independently selected directions` {}
    @Suite struct `No orthant construction boundary cases are defined` {}
    @Suite struct `No orthant construction integration cases are defined` {}
}

extension `Orthant construction assigns a direction to every axis`.`Orthants preserve repeated and independently selected directions` {
    @Test
    func `repeating sets every axis`() {
        let orthant = Orthant<3>(repeating: .positive)
        #expect(orthant.directions[0] == .positive)
        #expect(orthant.directions[1] == .positive)
        #expect(orthant.directions[2] == .positive)
    }

    @Test
    func `Orthant construction evaluates a direction for each axis`() {
        let orthant = Orthant<3> { index in index == 1 ? .negative : .positive }
        #expect(orthant.directions[0] == .positive)
        #expect(orthant.directions[1] == .negative)
        #expect(orthant.directions[2] == .positive)
    }
}

@Suite
struct `Orthant opposition reverses every axis direction` {
    @Suite struct `Opposite orthants invert each stored direction` {}
    @Suite struct `Applying orthant opposition twice restores the original value` {}
    @Suite struct `No orthant opposition integration cases are defined` {}
}

extension `Orthant opposition reverses every axis direction`.`Opposite orthants invert each stored direction` {
    @Test
    func `opposite flips every axis`() {
        let orthant = Orthant<3> { index in index == 0 ? .positive : .negative }
        let antipode = orthant.opposite
        #expect(antipode.directions[0] == .negative)
        #expect(antipode.directions[1] == .positive)
        #expect(antipode.directions[2] == .positive)
    }
}

extension `Orthant opposition reverses every axis direction`.`Applying orthant opposition twice restores the original value` {
    @Test
    func `opposite is involution`() {
        let orthant = Orthant<2> { index in index == 0 ? .positive : .negative }
        #expect(orthant.opposite.opposite == orthant)
    }
}

@Suite
struct `Orthant equality and hashing distinguish direction combinations` {
    @Suite struct `Orthant equality and hashing preserve every axis direction` {}
    @Suite struct `No orthant equality and hashing boundary cases are defined` {}
    @Suite struct `No orthant equality and hashing integration cases are defined` {}
}

extension `Orthant equality and hashing distinguish direction combinations`.`Orthant equality and hashing preserve every axis direction` {
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
struct `Orthant ordering compares directions lexicographically` {
    @Suite struct `Orthant comparison gives the first axis greatest significance` {}
    @Suite struct `No orthant comparison boundary cases are defined` {}
    @Suite struct `No orthant comparison integration cases are defined` {}
}

extension `Orthant ordering compares directions lexicographically`.`Orthant comparison gives the first axis greatest significance` {
    @Test
    func `Orthant lexicographic ordering gives axis zero highest priority`() {
        let mm = Orthant<2>(repeating: .negative)
        let mp = Orthant<2> { $0 == 0 ? .negative : .positive }
        let pm = Orthant<2> { $0 == 0 ? .positive : .negative }
        #expect(mm < mp)
        #expect(mp < pm)
        #expect(mm < pm)
        #expect(pm > mm)
    }
}
