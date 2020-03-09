import XCTest
@testable import Combinatorics

final class PermutationsTests: XCTestCase {

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
            [1,2,3], [2,1,3], [3,1,2], [1,3,2], [2,3,1], [3,2,1]
        ]
        let res = Combinatorics.permutations(of: [1,2,3])
        XCTAssertTrue(res == exp)
    }

    func test_quadra() {
        let exp = [
            [1,2,3,4], [2,1,3,4], [3,1,2,4], [1,3,2,4], [2,3,1,4], [3,2,1,4],
            [4,2,1,3], [2,4,1,3], [1,4,2,3], [4,1,2,3], [2,1,4,3], [1,2,4,3],
            [1,3,4,2], [3,1,4,2], [4,1,3,2], [1,4,3,2], [3,4,1,2], [4,3,1,2],
            [4,3,2,1], [3,4,2,1], [2,4,3,1], [4,2,3,1], [3,2,4,1], [2,3,4,1]
        ]
        let res = Combinatorics.permutations(of: [1,2,3,4])
        XCTAssertTrue(res == exp)
    }

    func test_empty_async() {
        let a: [Int] = []
        Combinatorics.permutations(
            of: a,
            executionQueue: DispatchQueue.global(qos: .background),
            receiverQueue: DispatchQueue.main
        ) { res in
            XCTAssertTrue(Thread.isMainThread)
            XCTAssertTrue(res == [])
        }
    }

    func test_single_async() {
        let a = [1]
        let exp = [
            [1]
        ]
        Combinatorics.permutations(
            of: a,
            executionQueue: DispatchQueue.global(qos: .background),
            receiverQueue: DispatchQueue.main
        ) { res in
            XCTAssertTrue(Thread.isMainThread)
            XCTAssertTrue(res == exp)
        }
    }

    func test_pair_async() {
        let a = [1,2]
        let exp = [
            [1,2], [2,1]
        ]
        Combinatorics.permutations(
            of: a,
            executionQueue: DispatchQueue.global(qos: .background),
            receiverQueue: DispatchQueue.main
        ) { res in
            XCTAssertTrue(Thread.isMainThread)
            XCTAssertTrue(res == exp)
        }
    }

}
