import Foundation

// XXX Add background-executing versions, with callbacks returning Result or OperationResult ??

public enum Combinatorics {
    
    /// The result of this function is NOT cached.
    public static func factorial(of n: Int) -> Int {
        if n < 0 { return 0 }
        if n == 0 { return 1 }
        return n * factorial(of: n-1)
    }
    
    /// The result of this function is NOT cached.
    public static func choose(n: Int, k: Int) -> Int {
        guard n >= 1 && k >= 0 && k <= n else { return 0 }
        
        if k == 0 || k == n { return 1 }
        if k == 1 { return n }
        
        var ks = Array(2 ... k)
        var nmks = Array(1 ... (n-k))
        var res = 1
        var tmp: [Int] = []
        
        for num in Array(2 ... n) {
            res *= num
            tmp = []
            nmks.forEach { den in
                if res % den == 0 {
                    res /= den
                } else {
                    tmp += [den]
                }
            }
            nmks = tmp
            tmp = []
            ks.forEach { den in
                if res % den == 0 {
                    res /= den
                } else {
                    tmp += [den]
                }
            }
            ks = tmp
        }
        
        return res
    }
    
    /// The result of this function is NOT cached.
    public static func permutations<T>(of elements: ArraySlice<T>) -> [[T]] {
        var res: [[T]] = []
        elements.enumerated().forEach { k, entry in
            let prefix = elements.prefix(upTo: k)
            let suffix = elements.suffix(from: k+1)
            let slice = prefix + suffix
            if slice.isEmpty == false {
                let subPerms = permutations(of: slice)
                res += subPerms.map { [entry] + $0 }
            } else {
                res += [[entry]]
            }
        }
        return res
    }
    
    /// The result of this function is NOT cached.
    public static func permutations<T>(of elements: Array<T>) -> [[T]] {
        return permutations(of: ArraySlice(elements))
    }
    
    /// The result of this function is NOT cached.
    public static func combinations<T>(of elements: ArraySlice<T>, k: Int) -> [[T]] {
        if k < 1 || k > elements.count { return [] }
        if k == elements.count { return [Array(elements)] }
        
        guard let first = elements.first else { return [] }
        let head = [first]
        
        let body = elements.dropFirst()
        guard body.isEmpty == false else { return [head] }
        
        let subcombos = combinations(of: body, k: k - 1)
        var res = (subcombos.isEmpty ? [head] : subcombos.map { head + $0 })
        if body.count >= k { res += combinations(of: body, k: k) }
        
        return res
    }
    
    /// The result of this function is NOT cached.
    public static func combinations<T>(of elements: Array<T>, k: Int) -> [[T]] {
        return combinations(of: ArraySlice(elements), k: k)
    }
    
    /// The result of this function is NOT cached.
    public static func combinations<T>(of elements: ArraySlice<T>) -> [[T]] {
        guard elements.isEmpty == false else { return [] }
        return (1 ... elements.count)
            .map { k in combinations(of: elements, k: k) }
            .reduce([], +)
    }
    
    /// The result of this function is NOT cached.
    public static func combinations<T>(of elements: Array<T>) -> [[T]] {
        return combinations(of: ArraySlice(elements))
    }
    
}
