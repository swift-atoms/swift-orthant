import Foundation
import Orthant
import Testing

@Suite struct `Orthant enumeration checks cardinal and ordinal representability` {
    @Test func `Counts are exact powers of two`() throws {
        #expect(try Orthant<0>.count == 1)
        #expect(try Orthant<1>.count == 2)
        #expect(try Orthant<2>.count == 4)
        #expect(try Orthant<3>.count == 8)
        #expect(try Orthant<4>.count == 16)
    }

    @Test func `Ordinals preserve the negative axis bit order`() throws {
        #expect(try Orthant<3>(repeating: .positive).ordinal == 0)
        #expect(try Orthant<3>(repeating: .negative).ordinal == 7)
        #expect(try Orthant<3> { $0 == 0 ? .negative : .positive }.ordinal == 1)
        #expect(try Orthant<3> { $0 == 2 ? .negative : .positive }.ordinal == 4)
    }

    @Test func `Enumeration contains every small orthant exactly once`() throws {
        #expect(try Array(Orthant<0>.allCases).count == 1)
        #expect(try Array(Orthant<1>.allCases).count == 2)
        #expect(try Array(Orthant<2>.allCases).count == 4)
        let cases = try Array(Orthant<3>.allCases)
        #expect(cases.count == 8)
        #expect(Set(cases).count == 8)
    }

    @Test func `Every enumerated value round trips through its ordinal`() throws {
        let cases = try Orthant<3>.allCases
        for (index, orthant) in cases.enumerated() {
            #expect(try orthant.ordinal == Ordinal(UInt(index)))
            #expect(try Orthant<3>(ordinal: orthant.ordinal) == orthant)
            #expect(try cases.element(at: orthant.ordinal) == orthant)
        }
        #expect(cases.element(at: 8) == nil)
        #expect(cases.element(at: Ordinal(UInt.max)) == nil)
    }

    @Test func `Zero dimensional iteration yields once and stays exhausted`() throws {
        var iterator = try Orthant<0>.allCases.makeIterator()
        #expect(iterator.next() == Orthant<0>(repeating: .positive))
        #expect(iterator.next() == nil)
        #expect(iterator.next() == nil)
        #expect(try Orthant<0>(ordinal: 0) == Orthant<0>(repeating: .negative))
    }

    @Test(arguments: [UInt(8), 9, UInt.max])
    func `Small dimensions reject ordinals that have extra direction bits`(bits: UInt) {
        #expect(throws: Orthant<3>.Error.ordinalOutOfBounds(Ordinal(bits))) {
            try Orthant<3>(ordinal: Ordinal(bits))
        }
    }

    @Test func `Zero dimensions reject every nonzero ordinal`() {
        #expect(throws: Orthant<0>.Error.ordinalOutOfBounds(1)) {
            try Orthant<0>(ordinal: 1)
        }
    }

    @Test func `The last representable enumeration remains lazy and exact`() throws {
        #if arch(arm64) || arch(x86_64)
            typealias Boundary = Orthant<63>
        #else
            typealias Boundary = Orthant<31>
        #endif
        let cases = try Boundary.allCases
        #expect(cases.count.rawValue == UInt.max / 2 + 1)
        #expect(Array(cases.prefix(3)).count == 3)
        #expect(try cases.prefix(3).map { try $0.ordinal.rawValue } == [0, 1, 2])
        let last = try #require(cases.element(at: Ordinal(cases.count.rawValue - 1)))
        #expect(last == Boundary(repeating: .negative))
        #expect(try last.ordinal.rawValue == cases.count.rawValue - 1)
        #expect(cases.element(at: Ordinal(cases.count.rawValue)) == nil)
    }

    @Test func `A full word ordinal fits even when the enumeration count does not`() throws {
        #if arch(arm64) || arch(x86_64)
            typealias FullWord = Orthant<64>
        #else
            typealias FullWord = Orthant<32>
        #endif
        #expect(throws: FullWord.Error.countOverflow) { try FullWord.count }
        #expect(throws: FullWord.Error.countOverflow) { try FullWord.allCases }
        let last = FullWord(repeating: .negative)
        #expect(try last.ordinal.rawValue == UInt.max)
        #expect(try FullWord(ordinal: Ordinal(UInt.max)) == last)
        #expect(try FullWord(repeating: .positive).ordinal == 0)
    }

    @Test func `High dimensional values reject only inexact ordinal conversions`() throws {
        #expect(throws: Orthant<128>.Error.countOverflow) { try Orthant<128>.allCases }
        let representable = try Orthant<128>(ordinal: Ordinal(UInt.max))
        #expect(try representable.ordinal.rawValue == UInt.max)
        #expect(representable.directions[UInt.bitWidth - 1] == .negative)
        #expect(representable.directions[UInt.bitWidth] == .positive)
        let unrepresentable = Orthant<128> { $0 == UInt.bitWidth ? .negative : .positive }
        #expect(throws: Orthant<128>.Error.ordinalOverflow) { try unrepresentable.ordinal }
        #expect(try Orthant<128>(repeating: .positive).ordinal == 0)
    }

    @Test func `High dimensional storage decoding and opposition preserve every direction`() throws {
        let value = Orthant<128> { $0.isMultiple(of: 3) ? .negative : .positive }
        #expect(value.opposite.opposite == value)
        #expect(value.directions[127] == .positive)
        #expect(value.opposite.directions[127] == .negative)
        let encoded = try JSONEncoder().encode(value)
        #expect(try JSONDecoder().decode(Orthant<128>.self, from: encoded) == value)
        #expect(throws: Orthant<128>.Error.ordinalOverflow) { try value.ordinal }
        #expect(Set([value, value.opposite]).count == 2)
    }
}
