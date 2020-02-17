import XCTest
@testable import Combinatorics

final class CombinationsTests: XCTestCase {

    private let ints: [Int] = [1,2,3,4,5]
    private var expectedCombos: [[[Int]]] = []

    override func setUp() {
        expectedCombos += [ints.map { [$0] }]

        var res: [[Int]]

        res = []
        for k1 in (1 ... 4) {
            for k2 in (k1+1 ... 5) {
                res += [[k1, k2]]
            }
        }
        expectedCombos += [res]

        res = []
        for k1 in (1 ... 3) {
            for k2 in (k1+1 ... 4) {
                for k3 in (k2+1 ... 5) {
                    res += [[k1, k2, k3]]
                }
            }
        }
        expectedCombos += [res]

        res = []
        for k1 in (1 ... 2) {
            for k2 in (k1+1 ... 3) {
                for k3 in (k2+1 ... 4) {
                    for k4 in (k3+1 ... 5) {
                        res += [[k1, k2, k3, k4]]
                    }
                }
            }
        }
        expectedCombos += [res]

        expectedCombos += [[ints]]
    }

    func test_individualCombos() {
        for k in (0 ..< ints.count) {
            let a1 = expectedCombos[k]
            let a2 = Combinatorics.combinations(of: ints, k: k+1)
            XCTAssertTrue(a1 == a2)
        }
    }

    func test_allCombos() {
        let a1 = Array(expectedCombos.joined())
        let a2 = Combinatorics.combinations(of: ints)
        XCTAssertTrue(a1 == a2)
    }

    func test_empty() {
        let ints: [Int] = []
        let exp: [[Int]] = []
        for k in (0 ... ints.count + 1) {
            let res = Combinatorics.combinations(of: ints, k: k)
            XCTAssertTrue(res == exp)
        }
        let res = Combinatorics.combinations(of: ints)
        XCTAssertTrue(res == exp)
    }

    func test_single() {
        let ints = [1]
        for k in (0 ... ints.count + 1) {
            let res = Combinatorics.combinations(of: ints, k: k)
            let exp: [[Int]]
            switch k {
            case 1: exp = [[1]]
            default: exp = []
            }
            XCTAssertTrue(res == exp)
        }
        let exp = [[1]]
        let res = Combinatorics.combinations(of: ints)
        XCTAssertTrue(res == exp)
    }

    func test_pair() {
        let ints = [1,2]
        for k in (0 ... ints.count + 1) {
            let res = Combinatorics.combinations(of: ints, k: k)
            let exp: [[Int]]
            switch k {
            case 1: exp = [[1], [2]]
            case 2: exp = [[1,2]]
            default: exp = []
            }
            XCTAssertTrue(res == exp)
        }
        let exp = [ [1], [2], [1,2] ]
        let res = Combinatorics.combinations(of: ints)
        XCTAssertTrue(res == exp)
    }

    func test_triple() {
        let ints = [1,2,3]
        for k in (0 ... ints.count + 1) {
            let res = Combinatorics.combinations(of: ints, k: k)
            let exp: [[Int]]
            switch k {
            case 1: exp = [[1], [2], [3]]
            case 2: exp = [[1,2], [1,3], [2,3]]
            case 3: exp = [[1,2,3]]
            default: exp = []
            }
            XCTAssertTrue(res == exp)
        }
        let exp = [ [1], [2], [3], [1,2], [1,3], [2,3], [1,2,3] ]
        let res = Combinatorics.combinations(of: ints)
        XCTAssertTrue(res == exp)
    }

    func test_choose1() {
        for n in (1 ... 20) {
            for k in (0 ... n) {
                let exp = Combinatorics.factorial(of: n) / (
                    Combinatorics.factorial(of: n-k) * Combinatorics.factorial(of: k)
                )
                let res = Combinatorics.choose(n: n, k: k)
                XCTAssertTrue(res == exp)
            }
        }
    }

    func test_choose2() {
        let exp = 2_118_760
        let res = Combinatorics.choose(n: 50, k: 5)
        XCTAssertTrue(res == exp)
    }

}
