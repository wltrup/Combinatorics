# Combinatorics
![](https://img.shields.io/badge/platforms-iOS%2010%20%7C%20tvOS%2010%20%7C%20watchOS%204%20%7C%20macOS%2010.14-red)
[![Xcode](https://img.shields.io/badge/Xcode-11-blueviolet.svg)](https://developer.apple.com/xcode)
[![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg)](https://swift.org)
![GitHub tag (latest SemVer)](https://img.shields.io/github/v/tag/wltrup/Combinatorics)
![GitHub](https://img.shields.io/github/license/wltrup/Combinatorics)

## What

**Combinatorics** is a Swift Package Manager package for iOS/tvOS (10.0 and above), watchOS (4.0 and above), and macOS (10.14 and above), under Swift 5.0 and above,  defining functions to efficiently compute permutations and combinations of given elements, as well as factorials and binomial coefficients:
```swift
public enum Combinatorics {
    
    public static func factorial(of n: Int) -> Int
    public static func choose(n: Int, k: Int) -> Int
    
    /// All permutations of `elements`
    public static func permutations<T>(of elements: ArraySlice<T>) -> [[T]]
    public static func permutations<T>(of elements: Array<T>) -> [[T]]
    
    /// All combinations of `elements`, taken k at a time
    public static func combinations<T>(of elements: ArraySlice<T>, k: Int) -> [[T]]
    public static func combinations<T>(of elements: Array<T>, k: Int) -> [[T]]
    
    /// All combinations of `elements`, taken k at a time, for all possible values of k
    public static func combinations<T>(of elements: ArraySlice<T>) -> [[T]]
    public static func combinations<T>(of elements: Array<T>) -> [[T]]
    
}
```

## Installation

**Combinatorics** is provided only as a Swift Package Manager package, because I'm moving away from CocoaPods and Carthage, and can be easily installed directly from Xcode.

## Author

Wagner Truppel, trupwl@gmail.com

## License

**Combinatorics** is available under the MIT license. See the [LICENSE](./LICENSE) file for more info.
