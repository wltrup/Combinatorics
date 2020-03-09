import XCTest
@testable import Combinatorics

final class BinomialCoefficientTests: XCTestCase {

    func test_integer_binomialCoefficient_invalid_input_n() {
        let exp: UInt = 0
        let res: UInt = Combinatorics.binomialCoefficient(n: 0, k: 2)
        XCTAssertTrue(res == exp)
    }

    func test_integer_binomialCoefficient_invalid_input_k() {
        let exp: UInt = 0
        let res: UInt = Combinatorics.binomialCoefficient(n: 5, k: 7)
        XCTAssertTrue(res == exp)
    }

    func test_integer_binomialCoefficient() {
        for n: UInt in (1 ... 20) {
            for k: UInt in (0 ... n) {
                let exp: UInt = Combinatorics.factorial(of: n) / (
                    Combinatorics.factorial(of: n-k) * Combinatorics.factorial(of: k)
                )
                let res: UInt = Combinatorics.binomialCoefficient(n: n, k: k)
                XCTAssertTrue(res == exp)
            }
        }
    }

    func test_double_binomialCoefficient_invalid_input_n() {
        let exp: Double = 0
        let res: Double = Combinatorics.binomialCoefficient(n: 0, k: 2)
        XCTAssertTrue(res == exp)
    }

    func test_double_binomialCoefficient_invalid_input_k() {
        let exp: Double = 0
        let res: Double = Combinatorics.binomialCoefficient(n: 5, k: 7)
        XCTAssertTrue(res == exp)
    }

    func test_double_binomialCoefficient() {
        for n: UInt in (1 ... 20) {
            for k: UInt in (0 ... n) {
                let exp: Double = Combinatorics.factorial(of: n) / (
                    Combinatorics.factorial(of: n-k) * Combinatorics.factorial(of: k)
                )
                let res: Double = Combinatorics.binomialCoefficient(n: n, k: k)
                XCTAssertTrue(res == exp)
            }
        }
    }

    func test_double_binomialCoefficient_input_too_large() {
        let exp: Double = .infinity
        let res: Double = Combinatorics.binomialCoefficient(n: 1000, k: 500)
        XCTAssertTrue(res == exp)
    }

    func test_integer_result_binomialCoefficient_invalid_input_n() {
        let exp: Combinatorics.BinomialCoefficientIntegerResult = .failure(.invalidInput)
        let res: Combinatorics.BinomialCoefficientIntegerResult = Combinatorics.binomialCoefficient(n: 0, k: 2)
        XCTAssertTrue(res == exp)
    }

    func test_integer_result_binomialCoefficient_invalid_input_k() {
        let exp: Combinatorics.BinomialCoefficientIntegerResult = .failure(.invalidInput)
        let res: Combinatorics.BinomialCoefficientIntegerResult = Combinatorics.binomialCoefficient(n: 5, k: 7)
        XCTAssertTrue(res == exp)
    }

    func test_integer_result_binomialCoefficient() {
        for n: UInt in (1 ... 20) {
            for k: UInt in (0 ... n) {
                let exp: UInt = Combinatorics.factorial(of: n) / (
                    Combinatorics.factorial(of: n-k) * Combinatorics.factorial(of: k)
                )
                let res: Combinatorics.BinomialCoefficientIntegerResult =
                    Combinatorics.binomialCoefficient(n: n, k: k)
                XCTAssertTrue(res == .success(exp))
            }
        }
    }

    func test_integer_result_binomialCoefficient_input_too_large() {
        let exp: Combinatorics.BinomialCoefficientIntegerResult = .failure(.inputTooLarge)
        let res: Combinatorics.BinomialCoefficientIntegerResult =
            Combinatorics.binomialCoefficient(n: 1000, k: 500)
        XCTAssertTrue(res == exp)
    }

    func test_double_result_binomialCoefficient_invalid_input_n() {
        let exp: Combinatorics.BinomialCoefficientDoubleResult = .failure(.invalidInput)
        let res: Combinatorics.BinomialCoefficientDoubleResult = Combinatorics.binomialCoefficient(n: 0, k: 2)
        XCTAssertTrue(res == exp)
    }

    func test_double_result_binomialCoefficient_invalid_input_k() {
        let exp: Combinatorics.BinomialCoefficientDoubleResult = .failure(.invalidInput)
        let res: Combinatorics.BinomialCoefficientDoubleResult = Combinatorics.binomialCoefficient(n: 5, k: 7)
        XCTAssertTrue(res == exp)
    }

    func test_double_result_binomialCoefficient() {
        for n: UInt in (1 ... 20) {
            for k: UInt in (0 ... n) {
                let exp: UInt = Combinatorics.factorial(of: n) / (
                    Combinatorics.factorial(of: n-k) * Combinatorics.factorial(of: k)
                )
                let res: Combinatorics.BinomialCoefficientDoubleResult =
                    Combinatorics.binomialCoefficient(n: n, k: k)
                XCTAssertTrue(res == .success(Double(exp)))
            }
        }
    }

    func test_double_result_binomialCoefficient_input_too_large() {
        let exp: Combinatorics.BinomialCoefficientDoubleResult = .failure(.inputTooLarge)
        let res: Combinatorics.BinomialCoefficientDoubleResult =
            Combinatorics.binomialCoefficient(n: 1000, k: 500)
        XCTAssertTrue(res == exp)
    }

}
