import Foundation

// MARK: - Permutations

extension Combinatorics {

    // Todo: a more performant implementation.
    
    /// Computes all *permutations* of the input elements. The result is, therefore,
    /// an array of length-`n` arrays, where `n` is the length of the input array.
    /// The implementation aims to be as efficient as possible by allocating upfront
    /// all the storage it needs.
    ///
    /// There's also an asynchronous variant that is executed on a given dispatch queue
    /// and which provides its result on another queue (typically, these would be the global
    /// queue with a specified quality-of-service class and the main queue, respectively).
    ///
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

    /// Computes all *permutations* of the input elements. The result is, therefore,
    /// an array of length-`n` arrays, where `n` is the length of the input array.
    /// The implementation aims to be as efficient as possible by allocating upfront
    /// all the storage it needs.
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

    /// Computes all *permutations* of the input elements. The result is, therefore,
    /// an array of length-`n` arrays, where `n` is the length of the input array.
    /// The implementation aims to be as efficient as possible by allocating upfront
    /// all the storage it needs.
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

    /// Computes all *permutations* of the input elements. The result is, therefore,
    /// an array of length-`n` arrays, where `n` is the length of the input array.
    /// The implementation aims to be as efficient as possible by allocating upfront
    /// all the storage it needs.
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
