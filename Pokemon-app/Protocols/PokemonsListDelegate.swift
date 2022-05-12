import Foundation

protocol PokemonsListDelegate: AnyObject {
    
    func didSelect(pokemon: URL)
}
