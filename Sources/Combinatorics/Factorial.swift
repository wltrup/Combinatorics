import Foundation

// MARK: - Factorial

extension Combinatorics {

    public enum FactorialError: Error {
        case inputTooLarge
    }

    public typealias FactorialIntegerResult = Result<UInt, FactorialError>
    public typealias FactorialDoubleResult = Result<Double, FactorialError>

}

extension Combinatorics {

    /// Computes the `factorial` of the input integer. This implementation
    /// does *not* validate its input. On a 32-bit device, the maximum input
    /// is `n = 12` while, on a 64-bit device, it's `n = 20`. This implementation
    /// will then *crash* for inputs larger than those.
    ///
    public static func factorial(of n: UInt) -> UInt {
        if n == 0 { return 1 }
        return n * factorial(of: n-1)
    }

    /// Computes the `factorial` of the input integer, returning the result
    /// as a `Double`. This allows for the computation of the factorial for
    /// larger inputs than if the result was forced into an integer type. This
    /// implementation does *not* validate its input, however. On a 64-bit
    /// device, the maximum input is `n = 170`. This implementation will then
    /// return `Double.infinity` for the result.
    ///
    public static func factorial(of n: UInt) -> Double {
        if n == 0 { return 1 }
        return Double(n) * factorial(of: n-1)
    }

    /// Computes the `factorial` of the input integer. On a 32-bit device,
    /// the maximum input is `n = 12` while, on a 64-bit device, it's `n = 20`.
    /// The function returns an error result for inputs larger than those.
    ///
    public static func factorial(of n: UInt) -> FactorialIntegerResult {

        if UInt.max == UInt32.max && n > 12 { return .failure(.inputTooLarge) }
        if UInt.max == UInt64.max && n > 20 { return .failure(.inputTooLarge) }

        if n == 0 { return .success(1) }

        let res: FactorialIntegerResult = factorial(of: n-1)
        switch res {
            case let .failure(error):
                return .failure(error)
            case let .success(value):
                return .success(n * value)
        }

    }

    /// Computes the `factorial` of the input integer, returning the result
    /// as a `Double`. This allows for the computation of the factorial for
    /// larger inputs than if the result was forced into an integer type.
    /// On a 64-bit device, the maximum input is `n = 170`. The function
    /// returns an error result for inputs larger than that.
    ///
    public static func factorial(of n: UInt) -> FactorialDoubleResult {

        if UInt.max == UInt64.max && n > 170 { return .failure(.inputTooLarge) }

        if n == 0 { return .success(1) }

        let res: FactorialDoubleResult = factorial(of: n-1)
        switch res {
            case let .failure(error):
                return .failure(error)
            case let .success(value):
                return .success(Double(n) * value)
        }

    }

}
