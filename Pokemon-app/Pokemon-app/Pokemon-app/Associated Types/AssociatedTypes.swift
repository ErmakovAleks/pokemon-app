import Foundation

// MARK: -
// MARK: Associated Types

typealias Completion<T> = (Result<T, Error>) -> ()
typealias PokemonsCardsCompletion = Completion<[Pokemon]>
