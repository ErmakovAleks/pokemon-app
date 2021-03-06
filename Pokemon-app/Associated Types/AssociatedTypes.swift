import Foundation
import UIKit

// MARK: -
// MARK: Associated Types

typealias Completion<T> = (Result<T, Error>) -> ()
typealias Detail = (name: String, height: Int, weight: Int, image: UIImage)
typealias PokemonsCardsCompletion = Completion<[Pokemon]>
typealias PokemonDetailCompletion = Completion<Detail>
