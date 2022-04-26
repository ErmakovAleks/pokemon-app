import Foundation
import UIKit

// MARK: -
// MARK: Associated Types

typealias Completion<T> = (Result<T, Error>) -> ()
typealias PokemonsCardsCompletion = Completion<[Pokemon]>
typealias PokemonImageCompletion = Completion<UIImage>
