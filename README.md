# Combinatorics
![](https://img.shields.io/badge/platforms-iOS%2010%20%7C%20tvOS%2010%20%7C%20watchOS%204%20%7C%20macOS%2010.14-red)
[![Xcode](https://img.shields.io/badge/Xcode-11-blueviolet.svg)](https://developer.apple.com/xcode)
[![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg)](https://swift.org)
![GitHub tag (latest SemVer)](https://img.shields.io/github/v/tag/wltrup/Combinatorics)
![GitHub](https://img.shields.io/github/license/wltrup/Combinatorics)

## What

**Combinatorics** is a Swift Package Manager package for iOS/tvOS (10.0 and above), watchOS (4.0 and above), and macOS (10.14 and above), under Swift 5.0 and above,  defining functions to efficiently compute permutations and combinations of given elements, as well as factorials and binomial coefficients.

The functionality is provided by several static fuctions on an empty enumeraton, `Combinatorics`, and there are several variants of each API, depending on the type of result one needs (`UInt`, `Double`, `Result<UInt, Error>`, or `Result<UInt, Error>` for `factorial(of n:)` and `binomialCoefficient(n: k:)`, for instance) and on whether or not the computations are done in the background (for `combinations` and `permutations`).

The variants of `factorial(of n:)` and `binomialCoefficient(n: k:)` with `UInt` return types can only compute their results for relatively small values of their inputs, but their results are *exact*. The `Double` variants allow for larger inputs and return values but do not provide exact results. The variants using Swift's `Result<Success, Failure>` type provide input validation and better handling of error conditions. These are all synchronous since their computational cost is rather small, so there's not much point in having asynchronous variants for them.

In contrast, generating `combinations` and `permutations` can be costly even for inputs that aren't particularly large. Therefore, asynchronous versions of these *are* provided but they all assume inputs that are within the limits of `UInt` storage so  no `Double` or `Result`-type variants are provided for them.

Here's the full API:
```swift
public enum Combinatorics {
    
    // Factorials

    public enum FactorialError: Error {
        case inputTooLarge
    }

    public typealias FactorialIntegerResult = Result<UInt, FactorialError>
    public typealias FactorialDoubleResult = Result<Double, FactorialError>

    public static func factorial(of n: UInt) -> UInt
    public static func factorial(of n: UInt) -> Double
    public static func factorial(of n: UInt) -> FactorialIntegerResult
    public static func factorial(of n: UInt) -> FactorialDoubleResult
    
    // Binomial Coefficients

    public enum BinomialCoefficientError: Error {
        case invalidInput
        case inputTooLarge
    }

    public typealias BinomialCoefficientIntegerResult = Result<UInt, BinomialCoefficientError>
    public typealias BinomialCoefficientDoubleResult = Result<Double, BinomialCoefficientError>

    public static func binomialCoefficient(n: UInt, k: UInt) -> UInt 
    public static func binomialCoefficient(n: UInt, k: UInt) -> Double 
    public static func binomialCoefficient(n: UInt, k: UInt) -> BinomialCoefficientIntegerResult 
    public static func binomialCoefficient(n: UInt, k: UInt) -> BinomialCoefficientDoubleResult 
    
    // Combinations
    
    public typealias CombinationsCompletionHandler<T> = ([[T]]) -> Void

    // All combinations of `elements`, taken k at a time
    
    public static func combinations<T>(of elements: ArraySlice<T>, k: Int) -> [[T]] 
    public static func combinations<T>(of elements: ArraySlice<T>, k: Int,
        executionQueue: DispatchQueue,
        receiverQueue: DispatchQueue,
        completion: @escaping CombinationsCompletionHandler<T>
    )
    
    public static func combinations<T>(of elements: Array<T>, k: Int) -> [[T]] 
    public static func combinations<T>(of elements: Array<T>, k: Int,
        executionQueue: DispatchQueue,
        receiverQueue: DispatchQueue,
        completion: @escaping CombinationsCompletionHandler<T>
    ) 

    // All combinations of `elements`, taken k at a time, for all possible values of k

    public static func combinations<T>(of elements: ArraySlice<T>) -> [[T]] 
    public static func combinations<T>(of elements: ArraySlice<T>,
        executionQueue: DispatchQueue,
        receiverQueue: DispatchQueue,
        completion: @escaping CombinationsCompletionHandler<T>
    ) 

    public static func combinations<T>(of elements: Array<T>) -> [[T]] 
    public static func combinations<T>(of elements: Array<T>,
        executionQueue: DispatchQueue,
        receiverQueue: DispatchQueue,
        completion: @escaping CombinationsCompletionHandler<T>
    )
    
    // Permutations
    
    // All permutations of `elements`
    public static func permutations<T>(of elements: ArraySlice<T>) -> [[T]]
    public static func permutations<T>(of elements: Array<T>) -> [[T]]

}
```

## Installation

**Combinatorics** is provided only as a Swift Package Manager package, because I'm moving away from CocoaPods and Carthage, and can be easily installed directly from Xcode.

## Author

Wagner Truppel, trupwl@gmail.com

## License

**Combinatorics** is available under the MIT license. See the [LICENSE](./LICENSE) file for more info.
