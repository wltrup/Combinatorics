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
            let exp = expectedCombos[k]
            let res = Combinatorics.combinations(of: ints, k: k+1)
            XCTAssertTrue(res == exp)
        }
    }

    func test_allCombos() {
        let exp = Array(expectedCombos.joined())
        let res = Combinatorics.combinations(of: ints)
        XCTAssertTrue(res == exp)
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

    func test_individualCombos_async() {
        for k in (0 ..< ints.count) {
            let exp = expectedCombos[k]
            Combinatorics.combinations(
                of: ints,
                k: k+1,
                executionQueue: DispatchQueue.global(qos: .background),
                receiverQueue: DispatchQueue.main
            ) { res in
                XCTAssertTrue(Thread.isMainThread)
                XCTAssertTrue(res == exp)
            }
        }
    }

    func test_allCombos_async() {
        let exp = Array(expectedCombos.joined())
        Combinatorics.combinations(
            of: ints,
            executionQueue: DispatchQueue.global(qos: .background),
            receiverQueue: DispatchQueue.main
        ) { res in
            XCTAssertTrue(Thread.isMainThread)
            XCTAssertTrue(res == exp)
        }
    }

    func test_empty_async() {
        let ints: [Int] = []
        let exp: [[Int]] = []
        for k in (0 ... ints.count + 1) {
            Combinatorics.combinations(
                of: ints,
                k: k,
                executionQueue: DispatchQueue.global(qos: .background),
                receiverQueue: DispatchQueue.main
            ) { res in
                XCTAssertTrue(Thread.isMainThread)
                XCTAssertTrue(res == exp)
            }
        }
        Combinatorics.combinations(
            of: ints,
            executionQueue: DispatchQueue.global(qos: .background),
            receiverQueue: DispatchQueue.main
        ) { res in
            XCTAssertTrue(Thread.isMainThread)
            XCTAssertTrue(res == exp)
        }
    }

    func test_single_async() {
        let ints = [1]
        for k in (0 ... ints.count + 1) {
            let exp: [[Int]]
            switch k {
            case 1: exp = [[1]]
            default: exp = []
            }
            Combinatorics.combinations(
                of: ints,
                k: k,
                executionQueue: DispatchQueue.global(qos: .background),
                receiverQueue: DispatchQueue.main
            ) { res in
                XCTAssertTrue(Thread.isMainThread)
                XCTAssertTrue(res == exp)
            }
        }
        let exp = [[1]]
        Combinatorics.combinations(
            of: ints,
            executionQueue: DispatchQueue.global(qos: .background),
            receiverQueue: DispatchQueue.main
        ) { res in
            XCTAssertTrue(Thread.isMainThread)
            XCTAssertTrue(res == exp)
        }
    }

    func test_pair_async() {
        let ints = [1,2]
        for k in (0 ... ints.count + 1) {
            let exp: [[Int]]
            switch k {
            case 1: exp = [[1], [2]]
            case 2: exp = [[1,2]]
            default: exp = []
            }
            Combinatorics.combinations(
                of: ints,
                k: k,
                executionQueue: DispatchQueue.global(qos: .background),
                receiverQueue: DispatchQueue.main
            ) { res in
                XCTAssertTrue(Thread.isMainThread)
                XCTAssertTrue(res == exp)
            }
        }
        let exp = [ [1], [2], [1,2] ]
        Combinatorics.combinations(
            of: ints,
            executionQueue: DispatchQueue.global(qos: .background),
            receiverQueue: DispatchQueue.main
        ) { res in
            XCTAssertTrue(Thread.isMainThread)
            XCTAssertTrue(res == exp)
        }
    }

    func test_triple_async() {
        let ints = [1,2,3]
        for k in (0 ... ints.count + 1) {
            let exp: [[Int]]
            switch k {
            case 1: exp = [[1], [2], [3]]
            case 2: exp = [[1,2], [1,3], [2,3]]
            case 3: exp = [[1,2,3]]
            default: exp = []
            }
            Combinatorics.combinations(
                of: ints,
                k: k,
                executionQueue: DispatchQueue.global(qos: .background),
                receiverQueue: DispatchQueue.main
            ) { res in
                XCTAssertTrue(Thread.isMainThread)
                XCTAssertTrue(res == exp)
            }
        }
        let exp = [ [1], [2], [3], [1,2], [1,3], [2,3], [1,2,3] ]
        Combinatorics.combinations(
            of: ints,
            executionQueue: DispatchQueue.global(qos: .background),
            receiverQueue: DispatchQueue.main
        ) { res in
            XCTAssertTrue(Thread.isMainThread)
            XCTAssertTrue(res == exp)
        }
    }

}
