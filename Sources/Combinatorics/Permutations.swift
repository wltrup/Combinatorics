import Foundation

// MARK: - Permutations

extension Combinatorics {

    /// Computes all *permutations* of the input elements, using
    /// [Heap's algorithm](https://en.wikipedia.org/wiki/Heap%27s_algorithm).
    /// The result is, naturally, an array of length-`n` arrays, where `n` is
    /// the length of the input array. The implementation aims to be as efficient
    /// as possible by allocating upfront all the storage it needs and by minimising
    /// the number of swaps.
    ///
    /// There's also an asynchronous variant that is executed on a given dispatch queue
    /// and which provides its result on another queue (typically, these would be the global
    /// queue with a specified quality-of-service class and the main queue, respectively).
    ///
    public static func permutations<T>(of elements: ArraySlice<T>) -> [[T]] {

        let n = elements.count
        guard n > 0 else { return [] }
        if n == 1 { return [ [elements[0]] ] }
        if n == 2 { return [ [elements[0], elements[1]], [elements[1], elements[0]] ] }

        let uResultCount: UInt = factorial(of: UInt(n))
        let resultCount = Int(uResultCount)

        // Allocate all the space needed, upfront
        var res = [[T]](repeating: Array(elements), count: resultCount)
        var c = [Int](repeating: 0, count: n)
        var indices = [Int](0 ..< n)

        var resIdx = 1
        var i = 0
        while i < n {
            if c[i] < i {
                if i % 2 == 0 {
                    (indices[0], indices[i]) = (indices[i], indices[0])
                } else {
                    (indices[c[i]], indices[i]) = (indices[i], indices[c[i]])
                }
                for k in 0 ..< n { res[resIdx][k] = elements[indices[k]] }
                resIdx += 1
                c[i] += 1
                i = 0
            } else {
                c[i] = 0
                i += 1
            }
        }

        return res

    }

    public static func permutations_old<T>(of elements: ArraySlice<T>) -> [[T]] {
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

    /// Computes all *permutations* of the input elements, using
    /// [Heap's algorithm](https://en.wikipedia.org/wiki/Heap%27s_algorithm).
    /// The result is, naturally, an array of length-`n` arrays, where `n` is
    /// the length of the input array. The implementation aims to be as efficient
    /// as possible by allocating upfront all the storage it needs and by minimising
    /// the number of swaps.
    ///
    /// There's also an asynchronous variant that is executed on a given dispatch queue
    /// and which provides its result on another queue (typically, these would be the global
    /// queue with a specified quality-of-service class and the main queue, respectively).
    ///
    public static func permutations<T>(of elements: Array<T>) -> [[T]] {
        permutations(of: ArraySlice(elements))
    }

}

// MARK: - Permutations (asynchronous)

extension Combinatorics {

    public typealias PermutationsCompletionHandler<T> = ([[T]]) -> Void

    /// Computes all *permutations* of the input elements, using
    /// [Heap's algorithm](https://en.wikipedia.org/wiki/Heap%27s_algorithm).
    /// The result is, naturally, an array of length-`n` arrays, where `n` is
    /// the length of the input array. The implementation aims to be as efficient
    /// as possible by allocating upfront all the storage it needs and by minimising
    /// the number of swaps.
    ///
    /// This asynchronous variant executes its code on a given dispatch queue (`executionQueue`)
    /// and provides its result on another queue (`receiverQueue`). Typically, these would be
    /// the global queue with a specified quality-of-service class and the main queue,
    /// respectively.
    ///
    /// There's also a synchronous variant.
    ///
    public static func permutations<T>(
        of elements: ArraySlice<T>,
        executionQueue: DispatchQueue,
        receiverQueue: DispatchQueue,
        completion: @escaping PermutationsCompletionHandler<T>
    ) {
        executionQueue.async {
            let result = permutations(of: elements)
            receiverQueue.async {
                completion(result)
            }
        }
    }

    /// Computes all *permutations* of the input elements, using
    /// [Heap's algorithm](https://en.wikipedia.org/wiki/Heap%27s_algorithm).
    /// The result is, naturally, an array of length-`n` arrays, where `n` is
    /// the length of the input array. The implementation aims to be as efficient
    /// as possible by allocating upfront all the storage it needs and by minimising
    /// the number of swaps.
    ///
    /// This asynchronous variant executes its code on a given dispatch queue (`executionQueue`)
    /// and provides its result on another queue (`receiverQueue`). Typically, these would be
    /// the global queue with a specified quality-of-service class and the main queue,
    /// respectively.
    ///
    /// There's also a synchronous variant.
    ///
    public static func permutations<T>(
        of elements: Array<T>,
        executionQueue: DispatchQueue,
        receiverQueue: DispatchQueue,
        completion: @escaping PermutationsCompletionHandler<T>
    ) {
        permutations(
            of: ArraySlice(elements),
            executionQueue: executionQueue,
            receiverQueue: receiverQueue,
            completion: completion
        )
    }

}
