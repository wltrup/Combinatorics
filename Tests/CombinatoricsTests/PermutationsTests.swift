import XCTest
@testable import Combinatorics

final class PermutationsTests: XCTestCase {

    func test_factorialNeg() {
        let exp = 0
        let res = Combinatorics.factorial(of: -3)
        XCTAssertTrue(res == exp)
    }

    func test_factorialZero() {
        let exp = 1
        let res = Combinatorics.factorial(of: 0)
        XCTAssertTrue(res == exp)
    }

    func test_factorial1() {
        let exp = 1
        let res = Combinatorics.factorial(of: 1)
        XCTAssertTrue(res == exp)
    }

    func test_factorial5() {
        let exp = 120
        let res = Combinatorics.factorial(of: 5)
        XCTAssertTrue(res == exp)
    }

    func test_empty() {
        let a: [Int] = []
        let res = Combinatorics.permutations(of: a)
        XCTAssertTrue(res == [])
    }

    func test_single() {
        let res = Combinatorics.permutations(of: [1])
        XCTAssertTrue(res == [[1]])
    }

    func test_pair() {
        let exp = [
            [1,2], [2,1]
        ]
        let res = Combinatorics.permutations(of: [1,2])
        XCTAssertTrue(res == exp)
    }

    func test_triple() {
        let exp = [
            [1,2,3], [1,3,2], [2,1,3], [2,3,1], [3,1,2], [3,2,1]
        ]
        let res = Combinatorics.permutations(of: [1,2,3])
        XCTAssertTrue(res == exp)
    }

    func test_quadra() {
        let exp = [
            [1,2,3,4], [1,2,4,3], [1,3,2,4], [1,3,4,2], [1,4,2,3], [1,4,3,2],
            [2,1,3,4], [2,1,4,3], [2,3,1,4], [2,3,4,1], [2,4,1,3], [2,4,3,1],
            [3,1,2,4], [3,1,4,2], [3,2,1,4], [3,2,4,1], [3,4,1,2], [3,4,2,1],
            [4,1,2,3], [4,1,3,2], [4,2,1,3], [4,2,3,1], [4,3,1,2], [4,3,2,1]
        ]
        let res = Combinatorics.permutations(of: [1,2,3,4])
        XCTAssertTrue(res == exp)
    }

}
