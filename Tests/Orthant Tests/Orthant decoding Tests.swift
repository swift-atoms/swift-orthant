import Foundation
import Orthant
import Testing

@Suite struct `Decoding preserves the orthant dimension` {
    @Test func `Every three dimensional orthant round trips`() throws {
        for orthant in try Orthant<3>.allCases {
            let data = try JSONEncoder().encode(orthant)
            #expect(try JSONDecoder().decode(Orthant<3>.self, from: data) == orthant)
        }
    }

    @Test func `Decoding rejects fewer directions than the dimension`() throws {
        let data = try JSONEncoder().encode([Direction.positive])
        #expect(throws: DecodingError.self) {
            try JSONDecoder().decode(Orthant<2>.self, from: data)
        }
    }

    @Test func `Decoding rejects more directions than the dimension`() throws {
        let data = try JSONEncoder().encode([Direction.positive, .negative, .positive])
        #expect(throws: DecodingError.self) {
            try JSONDecoder().decode(Orthant<2>.self, from: data)
        }
    }

    @Test func `Zero dimensions decode only an empty sequence`() throws {
        let empty = Orthant<0>(repeating: .positive)
        let data = try JSONEncoder().encode(empty)
        #expect(try JSONDecoder().decode(Orthant<0>.self, from: data) == empty)
        #expect(throws: DecodingError.self) {
            try JSONDecoder().decode(
                Orthant<0>.self,
                from: JSONEncoder().encode([Direction.positive])
            )
        }
    }

    @Test func `Zero dimensions contain one self opposite orthant`() throws {
        let empty = Orthant<0>(repeating: .positive)
        #expect(try Orthant<0>.count == 1)
        #expect(try empty.ordinal == 0)
        #expect(try Array(Orthant<0>.allCases) == [empty])
        #expect(empty.opposite == empty)
    }
}
