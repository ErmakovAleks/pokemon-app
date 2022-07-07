import Foundation
import UIKit

// MARK: -
// MARK: Associated Types

typealias ResultCompletion<T> = (Result<T, Error>) -> ()
typealias Detail = (name: String?, height: Int?, weight: Int?, image: UIImage?)
typealias PokemonsCardsCompletion = ResultCompletion<Void>
typealias PokemonDetailCompletion = ResultCompletion<Void>
typealias PokemonsResult = Result<[Pokemon], Error>
typealias DetailsResult = Result<PokemonDetails, Error>
