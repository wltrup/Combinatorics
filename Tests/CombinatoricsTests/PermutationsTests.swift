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

    func test_perf() {
        var start: Date
        var end: Date
        for n in 1 ... 10 {
            let input = ArraySlice([Int](1 ... n))
            start = Date()
            _ = Combinatorics.permutations_old(of: input)
            end = Date()
            let oldDelta = end.timeIntervalSince(start)
            start = Date()
            _ = Combinatorics.permutations(of: input)
            end = Date()
            let newDelta = end.timeIntervalSince(start)
            print("-----")
            print("n = \(n)")
            print("old = \(oldDelta)")
            print("new = \(newDelta)")
            let r = Double(Int(1000 * (oldDelta / newDelta))) / 1000
            print("old is \(r) times slower than new")
            let s = Double(Int(100000 * (oldDelta - newDelta) / newDelta)) / 1000
            print("old is \(s) % slower than new")
        }
        print("-----")
    }

}
