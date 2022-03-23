import Foundation

protocol PokemonsDataProvider {
    
    func data(count: Int, completion: @escaping PokemonsCardsCompletion)
}
