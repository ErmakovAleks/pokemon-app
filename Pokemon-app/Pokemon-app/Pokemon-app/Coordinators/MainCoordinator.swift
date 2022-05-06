import Foundation
import UIKit

class MainCoordinator: UINavigationController, Coordinator, PokemonsListDelegate, PokemonDetailDelegate {
    
    // MARK: -
    // MARK: Public variables
    
    weak var navController: UINavigationController?
    var detailURL: URL?
    let requester = URLSessionPokemonsRequester()
    
    // MARK: -
    // MARK: Public functions
    
    func didSelect(pokemon: URL) {
        self.detailURL = pokemon
        self.openPokemonDetail(url: pokemon)
        print("didSelect!")
    }
    
    private func start() {
        let viewController = PokemonsListController(provider: self.requester)
        viewController.pokemonsListDelegate = self
        pushViewController(viewController, animated: true)
    }
    
    func openPokemonDetail(url: URL) {
        let pokemonDetail = PokemonDetailController(provider: self.requester)
        pokemonDetail.pokemonDetailDelegate = self
        pushViewController(pokemonDetail, animated: true)
    }
    
    // MARK: -
    // MARK: ViewController Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .orange
        
        start()
    }
}
