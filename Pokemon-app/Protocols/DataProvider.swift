import Foundation
import UIKit

protocol PokemonsDataProvider {
    
    func list(count: Int, completion: @escaping PokemonsCardsCompletion)
    
    func details(url: URL, completion: @escaping PokemonDetailCompletion)
}
