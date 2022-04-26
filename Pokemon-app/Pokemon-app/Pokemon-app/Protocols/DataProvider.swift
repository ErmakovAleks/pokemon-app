import Foundation
import UIKit

protocol PokemonsDataProvider {
    
    func list(count: Int, completion: @escaping PokemonsCardsCompletion)
    
    //temp
    func pokemonImage(number: Int, handler: ((UIImage) -> ()))
}
