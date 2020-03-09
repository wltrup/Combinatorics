import XCTest
@testable import Combinatorics

final class FactorialTests: XCTestCase {

    func test_integer_factorial_zero() {
        let exp = 1
        let res: UInt = Combinatorics.factorial(of: 0)
        XCTAssertTrue(res == exp)
    }

    func test_integer_factorial_1() {
        let exp = 1
        let res: UInt = Combinatorics.factorial(of: 1)
        XCTAssertTrue(res == exp)
    }

    func test_integer_factorial_5() {
        let exp = 120
        let res: UInt = Combinatorics.factorial(of: 5)
        XCTAssertTrue(res == exp)
    }

    func test_integer_factorial_12() {
        let exp = 479001600
        let res: UInt = Combinatorics.factorial(of: 12)
        XCTAssertTrue(res == exp)
    }

    func test_double_factorial_zero() {
        let exp: Double = 1
        let res: Double = Combinatorics.factorial(of: 0)
        XCTAssertTrue(res == exp)
    }

    func test_double_factorial_1() {
        let exp: Double = 1
        let res: Double = Combinatorics.factorial(of: 1)
        XCTAssertTrue(res == exp)
    }

    func test_double_factorial_5() {
        let exp: Double = 120
        let res: Double = Combinatorics.factorial(of: 5)
        XCTAssertTrue(res == exp)
    }

    func test_double_factorial_50() {
        let exp: Double = 3.0414093201713376e+64
        let res: Double = Combinatorics.factorial(of: 50)
        XCTAssertTrue(res == exp)
    }

    func test_double_factorial_170() {
        let exp: Double = 7.257415615307994e+306
        let res: Double = Combinatorics.factorial(of: 170)
        XCTAssertTrue(res == exp)
    }

    func test_double_factorial_171() {
        let exp = Double.infinity
        let res: Double = Combinatorics.factorial(of: 171)
        XCTAssertTrue(res == exp)
    }

    func test_integer_result_factorial_zero() {
        let exp: Combinatorics.FactorialIntegerResult = .success(1)
        let res: Combinatorics.FactorialIntegerResult = Combinatorics.factorial(of: 0)
        XCTAssertTrue(res == exp)
    }

    func test_integer_result_factorial_1() {
        let exp: Combinatorics.FactorialIntegerResult = .success(1)
        let res: Combinatorics.FactorialIntegerResult = Combinatorics.factorial(of: 1)
        XCTAssertTrue(res == exp)
    }

    func test_integer_result_factorial_5() {
        let exp: Combinatorics.FactorialIntegerResult = .success(120)
        let res: Combinatorics.FactorialIntegerResult = Combinatorics.factorial(of: 5)
        XCTAssertTrue(res == exp)
    }

    func test_integer_result_factorial_12() {
        let exp: Combinatorics.FactorialIntegerResult = .success(479001600)
        let res: Combinatorics.FactorialIntegerResult = Combinatorics.factorial(of: 12)
        XCTAssertTrue(res == exp)
    }

    func test_integer_result_factorial_13() {
        if UInt.max == UInt32.max {
            let exp: Combinatorics.FactorialIntegerResult = .failure(.inputTooLarge)
            let res: Combinatorics.FactorialIntegerResult = Combinatorics.factorial(of: 13)
            XCTAssertTrue(res == exp)
        } else if UInt.max == UInt64.max {
            let exp: Combinatorics.FactorialIntegerResult = .success(6227020800)
            let res: Combinatorics.FactorialIntegerResult = Combinatorics.factorial(of: 13)
            XCTAssertTrue(res == exp)
        }
    }

    func test_integer_result_factorial_20() {
        if UInt.max == UInt64.max {
            let exp: Combinatorics.FactorialIntegerResult = .success(2432902008176640000)
            let res: Combinatorics.FactorialIntegerResult = Combinatorics.factorial(of: 20)
            XCTAssertTrue(res == exp)
        }
    }

    func test_integer_result_factorial_21() {
        let exp: Combinatorics.FactorialIntegerResult = .failure(.inputTooLarge)
        let res: Combinatorics.FactorialIntegerResult = Combinatorics.factorial(of: 21)
        XCTAssertTrue(res == exp)
    }

    func test_integer_result_factorial_30() {
        let exp: Combinatorics.FactorialIntegerResult = .failure(.inputTooLarge)
        let res: Combinatorics.FactorialIntegerResult = Combinatorics.factorial(of: 30)
        XCTAssertTrue(res == exp)
    }

    func test_double_result_factorial_zero() {
        let exp: Combinatorics.FactorialDoubleResult = .success(1)
        let res: Combinatorics.FactorialDoubleResult = Combinatorics.factorial(of: 0)
        XCTAssertTrue(res == exp)
    }

    func test_double_result_factorial_1() {
        let exp: Combinatorics.FactorialDoubleResult = .success(1)
        let res: Combinatorics.FactorialDoubleResult = Combinatorics.factorial(of: 1)
        XCTAssertTrue(res == exp)
    }

    func test_double_result_factorial_5() {
        let exp: Combinatorics.FactorialDoubleResult = .success(120)
        let res: Combinatorics.FactorialDoubleResult = Combinatorics.factorial(of: 5)
        XCTAssertTrue(res == exp)
    }

    func test_double_result_factorial_12() {
        let exp: Combinatorics.FactorialDoubleResult = .success(479001600)
        let res: Combinatorics.FactorialDoubleResult = Combinatorics.factorial(of: 12)
        XCTAssertTrue(res == exp)
    }

    func test_double_result_factorial_13() {
        let exp: Combinatorics.FactorialDoubleResult = .success(6227020800)
        let res: Combinatorics.FactorialDoubleResult = Combinatorics.factorial(of: 13)
        XCTAssertTrue(res == exp)
    }

    func test_double_result_factorial_20() {
        let exp: Combinatorics.FactorialDoubleResult = .success(2432902008176640000)
        let res: Combinatorics.FactorialDoubleResult = Combinatorics.factorial(of: 20)
        XCTAssertTrue(res == exp)
    }

    func test_double_result_factorial_21() {
        let exp: Combinatorics.FactorialDoubleResult = .success(5.109094217170944e+19)
        let res: Combinatorics.FactorialDoubleResult = Combinatorics.factorial(of: 21)
        XCTAssertTrue(res == exp)
    }

    func test_double_result_factorial_30() {
        let exp: Combinatorics.FactorialDoubleResult = .success(2.6525285981219103e+32)
        let res: Combinatorics.FactorialDoubleResult = Combinatorics.factorial(of: 30)
        XCTAssertTrue(res == exp)
    }

    func test_double_result_factorial_100() {
        let exp: Combinatorics.FactorialDoubleResult = .success(9.33262154439441e+157)
        let res: Combinatorics.FactorialDoubleResult = Combinatorics.factorial(of: 100)
        XCTAssertTrue(res == exp)
    }

    func test_double_result_factorial_170() {
        let exp: Combinatorics.FactorialDoubleResult = .success(7.257415615307994e+306)
        let res: Combinatorics.FactorialDoubleResult = Combinatorics.factorial(of: 170)
        XCTAssertTrue(res == exp)
    }

    func test_double_result_factorial_171() {
        let exp: Combinatorics.FactorialDoubleResult = .failure(.inputTooLarge)
        let res: Combinatorics.FactorialDoubleResult = Combinatorics.factorial(of: 171)
        XCTAssertTrue(res == exp)
    }

    func test_double_result_factorial_200() {
        let exp: Combinatorics.FactorialDoubleResult = .failure(.inputTooLarge)
        let res: Combinatorics.FactorialDoubleResult = Combinatorics.factorial(of: 200)
        XCTAssertTrue(res == exp)
    }

}
