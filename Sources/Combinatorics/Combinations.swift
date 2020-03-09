import Foundation

// MARK: - Combinations

extension Combinatorics {

    /// Computes all *combinations* of the input elements, taking `k` at a time. The
    /// result is, therefore, an array of length-`k` arrays. The implementation aims
    /// to be as efficient as possible by allocating upfront all the storage it needs.
    ///
    /// There's also an asynchronous variant that is executed on a given dispatch queue
    /// and which provides its result on another queue (typically, these would be the global
    /// queue with a specified quality-of-service class and the main queue, respectively).
    ///
    public static func combinations<T>(of elements: ArraySlice<T>, k: Int) -> [[T]] {

        let n = elements.count
        if k < 1 || k > n { return [] }
        if k == n { return [Array(elements)] }

        let uResultCount: UInt = binomialCoefficient(n: UInt(n), k: UInt(k))
        let resultCount = Int(uResultCount)

        // Allocate all the space needed, upfront
        let dummy = [T](repeating: elements[0], count: k)
        var result = [[T]](repeating: dummy, count: resultCount)
        var indices = [Int](0 ..< k)

        func incrementIndex(at i: Int) {
            let maxAllowedIndexValue = n - k + i
            if indices[i] == maxAllowedIndexValue && i > 0 {
                incrementIndex(at: i-1)
                indices[i] = indices[i-1] + 1
            } else {
                indices[i] += 1
            }
        }

        for i in 0 ..< resultCount {
            for j in 0 ..< k {
                result[i][j] = elements[indices[j]]
            }
            incrementIndex(at: k-1)
        }

        return result

    }

    /// Computes all *combinations* of the input elements, taking `k` at a time. The
    /// result is, therefore, an array of length-`k` arrays. The implementation aims
    /// to be as efficient as possible by allocating upfront all the storage it needs.
    ///
    /// There's also an asynchronous variant that is executed on a given dispatch queue
    /// and which provides its result on another queue (typically, these would be the global
    /// queue with a specified quality-of-service class and the main queue, respectively).
    ///
    public static func combinations<T>(of elements: Array<T>, k: Int) -> [[T]] {
        combinations(of: ArraySlice(elements), k: k)
    }

    /// Computes all *combinations* of the input elements, taking `k` at a time. The
    /// result is, therefore, an array of length-`k` arrays. The implementation aims
    /// to be as efficient as possible by allocating upfront all the storage it needs.
    ///
    /// There's also an asynchronous variant that is executed on a given dispatch queue
    /// and which provides its result on another queue (typically, these would be the global
    /// queue with a specified quality-of-service class and the main queue, respectively).
    ///
    public static func combinations<T>(of elements: ArraySlice<T>) -> [[T]] {
        guard elements.isEmpty == false else { return [] }
        return (1 ... elements.count)
            .map { k in combinations(of: elements, k: k) }
            .reduce([], +)
    }

    /// Computes all *combinations* of the input elements, taking `k` at a time. The
    /// result is, therefore, an array of length-`k` arrays. The implementation aims
    /// to be as efficient as possible by allocating upfront all the storage it needs.
    ///
    /// There's also an asynchronous variant that is executed on a given dispatch queue
    /// and which provides its result on another queue (typically, these would be the global
    /// queue with a specified quality-of-service class and the main queue, respectively).
    ///
    public static func combinations<T>(of elements: Array<T>) -> [[T]] {
        combinations(of: ArraySlice(elements))
    }

}

// MARK: - Combinations (asynchronous)

extension Combinatorics {

    public typealias CombinationsCompletionHandler<T> = ([[T]]) -> Void

    /// Computes all *combinations* of the input elements, taking `k` at a time. The
    /// result is, therefore, an array of length-`k` arrays. The implementation aims
    /// to be as efficient as possible by allocating upfront all the storage it needs.
    ///
    /// This asynchronous variant executes its code on a given dispatch queue (`executionQueue`)
    /// and provides its result on another queue (`receiverQueue`). Typically, these would be
    /// the global queue with a specified quality-of-service class and the main queue,
    /// respectively.
    ///
    /// There's also a synchronous variant.
    ///
    public static func combinations<T>(
        of elements: ArraySlice<T>,
        k: Int,
        executionQueue: DispatchQueue,
        receiverQueue: DispatchQueue,
        completion: @escaping CombinationsCompletionHandler<T>
    ) {
        executionQueue.async {
            let result = combinations(of: elements, k: k)
            receiverQueue.async {
                completion(result)
            }
        }
    }

    /// Computes all *combinations* of the input elements, taking `k` at a time. The
    /// result is, therefore, an array of length-`k` arrays. The implementation aims
    /// to be as efficient as possible by allocating upfront all the storage it needs.
    ///
    /// This asynchronous variant executes its code on a given dispatch queue (`executionQueue`)
    /// and provides its result on another queue (`receiverQueue`). Typically, these would be
    /// the global queue with a specified quality-of-service class and the main queue,
    /// respectively.
    ///
    /// There's also a synchronous variant.
    ///
    public static func combinations<T>(
        of elements: Array<T>,
        k: Int,
        executionQueue: DispatchQueue,
        receiverQueue: DispatchQueue,
        completion: @escaping CombinationsCompletionHandler<T>
    ) {
        combinations(
            of: ArraySlice(elements),
            k: k,
            executionQueue: executionQueue,
            receiverQueue: receiverQueue,
            completion: completion
        )
    }

    /// Computes all *combinations* of the input elements, taking `k` at a time. The
    /// result is, therefore, an array of length-`k` arrays. The implementation aims
    /// to be as efficient as possible by allocating upfront all the storage it needs.
    ///
    /// This asynchronous variant executes its code on a given dispatch queue (`executionQueue`)
    /// and provides its result on another queue (`receiverQueue`). Typically, these would be
    /// the global queue with a specified quality-of-service class and the main queue,
    /// respectively.
    ///
    /// There's also a synchronous variant.
    ///
    public static func combinations<T>(
        of elements: ArraySlice<T>,
        executionQueue: DispatchQueue,
        receiverQueue: DispatchQueue,
        completion: @escaping CombinationsCompletionHandler<T>
    ) {
        executionQueue.async {
            let result = combinations(of: elements)
            receiverQueue.async {
                completion(result)
            }
        }
    }

    /// Computes all *combinations* of the input elements, taking `k` at a time. The
    /// result is, therefore, an array of length-`k` arrays. The implementation aims
    /// to be as efficient as possible by allocating upfront all the storage it needs.
    ///
    /// This asynchronous variant executes its code on a given dispatch queue (`executionQueue`)
    /// and provides its result on another queue (`receiverQueue`). Typically, these would be
    /// the global queue with a specified quality-of-service class and the main queue,
    /// respectively.
    ///
    /// There's also a synchronous variant.
    ///
    public static func combinations<T>(
        of elements: Array<T>,
        executionQueue: DispatchQueue,
        receiverQueue: DispatchQueue,
        completion: @escaping CombinationsCompletionHandler<T>
    ) {
        combinations(
            of: ArraySlice(elements),
            executionQueue: executionQueue,
            receiverQueue: receiverQueue,
            completion: completion
        )
    }

}
