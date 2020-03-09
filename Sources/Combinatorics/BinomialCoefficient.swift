import Foundation

// MARK: - Binomial Coefficient

extension Combinatorics {

    public enum BinomialCoefficientError: Error {
        case invalidInput
        case inputTooLarge
    }

    public typealias BinomialCoefficientIntegerResult = Result<UInt, BinomialCoefficientError>
    public typealias BinomialCoefficientDoubleResult = Result<Double, BinomialCoefficientError>

}

extension Combinatorics {

    /// This function computes the number of combinations of `n` items,
    /// selecting `k` at a time, known as the `Binomial Coefficient C(n,k)`,
    /// but also colloquially referred to as `n choose k`. It has the value
    ///
    ///       C(n, k) = n! / ( (n-k)! k! ),
    ///
    /// where m! indicates the factorial of m.
    ///
    /// The implementation tries hard to avoid computing large intermediate
    /// results by performing exact divisions as soon as they're possible. For
    /// example, to compute `C(10, 4)`, rather than compute 10!, 6!, and 4!
    /// separately and then combine their results to obtain the final answer, the
    /// implementation effectively computes it this way:
    /// (10 / 2) x (9 / 3) x (8 / 4) x 7.
    ///
    /// This implementation does *not* validate its input and will *crash* on
    /// inputs that result in intermediate numbers that are too large to store
    /// as unsigned integers.
    ///
    public static func binomialCoefficient(n: UInt, k: UInt) -> UInt {
        
        guard n >= 1 && k <= n else { return 0 }

        if k == 0 || k == n { return 1 }
        if k == 1 || k == n-1 { return n }

        let larger  = max(n-k, k)
        let smaller = min(n-k, k)

        var smallers = Array(2 ... smaller)
        var tmp: [UInt] = []
        var res: UInt = 1

        for num in larger+1 ... n {

            // Can we exactly divide num by any of the numbers in smallers?
            // If so, do it now and remove the divisor from smallers. If
            // not, queue the divisor for later and move on.
            var x = num
            tmp = []
            smallers.forEach { den in
                if x % den == 0 {
                    x /= den
                } else {
                    tmp += [den]
                }
            }
            smallers = tmp

            res *= x

            // Can we exactly divide res by any of the numbers in smallers?
            // If so, do it now and remove the divisor from smallers. If
            // not, queue the divisor for later and move on.
            tmp = []
            smallers.forEach { den in
                if res % den == 0 {
                    res /= den
                } else {
                    tmp += [den]
                }
            }
            smallers = tmp

        }

        return res

    }

    /// This function computes the number of combinations of `n` items,
    /// selecting `k` at a time, known as the `Binomial Coefficient C(n,k)`,
    /// but also colloquially referred to as `n choose k`. It has the value
    ///
    ///       C(n, k) = n! / ( (n-k)! k! ),
    ///
    /// where m! indicates the factorial of m.
    ///
    /// The implementation tries hard to avoid computing large intermediate
    /// results by performing exact divisions as soon as they're possible. For
    /// example, to compute `C(10, 4)`, rather than compute 10!, 6!, and 4!
    /// separately and then combine their results to obtain the final answer, the
    /// implementation effectively computes it this way:
    /// (10 / 2) x (9 / 3) x (8 / 4) x 7.
    ///
    /// This implementation does *not* validate its input and returns `Double.infinity`
    /// on inputs that result in intermediate numbers that are too large to store
    /// as `Double` instances.
    ///
    public static func binomialCoefficient(n: UInt, k: UInt) -> Double {

        guard n >= 1 && k <= n else { return 0 }

        if k == 0 || k == n { return 1 }
        if k == 1 || k == n-1 { return Double(n) }

        let larger  = max(n-k, k)
        let smaller = min(n-k, k)

        var smallers = Array(2 ... smaller)
        var tmp: [UInt] = []
        var res: Double = 1

        for num in larger+1 ... n {

            // Can we exactly divide num by any of the numbers in smallers?
            // If so, do it now and remove the divisor from smallers. If
            // not, queue the divisor for later and move on.
            var x = num
            tmp = []
            smallers.forEach { den in
                if x % den == 0 {
                    x /= den
                } else {
                    tmp += [den]
                }
            }
            smallers = tmp

            res *= Double(x)

            // If multiplying res by x results in an overflow, bail out.
            guard res != Double.infinity else {
                return Double.infinity
            }

            // Can we exactly divide res by any of the numbers in smallers?
            // If so, do it now and remove the divisor from smallers. If
            // not, queue the divisor for later and move on.
            tmp = []
            smallers.forEach { den in
                let x = Double(den)
                if res.truncatingRemainder(dividingBy: x) == 0 {
                    res /= x
                } else {
                    tmp += [den]
                }
            }
            smallers = tmp

        }

        return res

    }

    /// This function computes the number of combinations of `n` items,
    /// selecting `k` at a time, known as the `Binomial Coefficient C(n,k)`,
    /// but also colloquially referred to as `n choose k`. It has the value
    ///
    ///       C(n, k) = n! / ( (n-k)! k! ),
    ///
    /// where m! indicates the factorial of m.
    ///
    /// The implementation tries hard to avoid computing large intermediate
    /// results by performing exact divisions as soon as they're possible. For
    /// example, to compute `C(10, 4)`, rather than compute 10!, 6!, and 4!
    /// separately and then combine their results to obtain the final answer, the
    /// implementation effectively computes it this way:
    /// (10 / 2) x (9 / 3) x (8 / 4) x 7.
    ///
    /// This implementation validates its input and will return an error result on
    /// invalid inputs as well as on inputs that result in intermediate numbers that
    /// are too large to store as unsigned integers.
    ///
    public static func binomialCoefficient(n: UInt, k: UInt) -> BinomialCoefficientIntegerResult {

        guard n >= 1 && k <= n else { return .failure(.invalidInput) }

        if k == 0 || k == n { return .success(1) }
        if k == 1 || k == n-1 { return .success(n) }

        let larger  = max(n-k, k)
        let smaller = min(n-k, k)

        var smallers = Array(2 ... smaller)
        var tmp: [UInt] = []
        var res: UInt = 1

        for num in larger+1 ... n {

            // Can we exactly divide num by any of the numbers in smallers?
            // If so, do it now and remove the divisor from smallers. If
            // not, queue the divisor for later and move on.
            var x = num
            tmp = []
            smallers.forEach { den in
                if x % den == 0 {
                    x /= den
                } else {
                    tmp += [den]
                }
            }
            smallers = tmp

            // If multiplying res by x results in an overflow, bail out.
            guard x <= UInt.max / res else {
                return .failure(.inputTooLarge)
            }

            res *= x

            // Can we exactly divide res by any of the numbers in smallers?
            // If so, do it now and remove the divisor from smallers. If
            // not, queue the divisor for later and move on.
            tmp = []
            smallers.forEach { den in
                if res % den == 0 {
                    res /= den
                } else {
                    tmp += [den]
                }
            }
            smallers = tmp

        }

        return .success(res)

    }

    /// This function computes the number of combinations of `n` items,
    /// selecting `k` at a time, known as the `Binomial Coefficient C(n,k)`,
    /// but also colloquially referred to as `n choose k`. It has the value
    ///
    ///       C(n, k) = n! / ( (n-k)! k! ),
    ///
    /// where m! indicates the factorial of m.
    ///
    /// The implementation tries hard to avoid computing large intermediate
    /// results by performing exact divisions as soon as they're possible. For
    /// example, to compute `C(10, 4)`, rather than compute 10!, 6!, and 4!
    /// separately and then combine their results to obtain the final answer, the
    /// implementation effectively computes it this way:
    /// (10 / 2) x (9 / 3) x (8 / 4) x 7.
    ///
    /// This implementation validates its input and will return an error result on
    /// invalid inputs as well as on inputs that result in intermediate numbers that
    /// are too large to store as `Double` instances.
    ///
    public static func binomialCoefficient(n: UInt, k: UInt) -> BinomialCoefficientDoubleResult {

        guard n >= 1 && k <= n else { return .failure(.invalidInput) }

        if k == 0 || k == n { return .success(1) }
        if k == 1 || k == n-1 { return .success(Double(n)) }

        let larger  = max(n-k, k)
        let smaller = min(n-k, k)

        var smallers = Array(2 ... smaller)
        var tmp: [UInt] = []
        var res: Double = 1

        for num in larger+1 ... n {

            // Can we exactly divide num by any of the numbers in smallers?
            // If so, do it now and remove the divisor from smallers. If
            // not, queue the divisor for later and move on.
            var x = num
            tmp = []
            smallers.forEach { den in
                if x % den == 0 {
                    x /= den
                } else {
                    tmp += [den]
                }
            }
            smallers = tmp

            res *= Double(x)

            // If multiplying res by x results in an overflow, bail out.
            guard res != Double.infinity else {
                return .failure(.inputTooLarge)
            }

            // Can we exactly divide res by any of the numbers in smallers?
            // If so, do it now and remove the divisor from smallers. If
            // not, queue the divisor for later and move on.
            tmp = []
            smallers.forEach { den in
                let x = Double(den)
                if res.truncatingRemainder(dividingBy: x) == 0 {
                    res /= x
                } else {
                    tmp += [den]
                }
            }
            smallers = tmp

        }

        return .success(res)

    }

}
