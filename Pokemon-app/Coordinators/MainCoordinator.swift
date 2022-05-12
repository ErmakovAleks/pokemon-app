import Foundation
import UIKit

class MainCoordinator: BaseCoordinator, PokemonsListDelegate {
    
    // MARK: -
    // MARK: Public variables
    
    let requester = URLSessionPokemonsRequester()
    
    // MARK: -
    // MARK: BaseCoordinator functions
    
    override func start() {
        let viewController = PokemonsListController(provider: self.requester)
        viewController.events.subscribe(
            onNext: {
                switch $0 {
                case .showDetails(url: let url):
                    self.didSelect(pokemon: url)
                }
            }
        ).disposed(by: viewController.disposeBag)
        self.pushViewController(viewController, animated: true)
    }
    
    // MARK: -
    // MARK: Private functions
    
    private func openPokemonDetail(pokemon: URL) {
        let pokemonDetail = PokemonDetailController(provider: self.requester, url: pokemon)
        self.pushViewController(pokemonDetail, animated: true)
    }
    
    // MARK: -
    // MARK: PokemonsListDelegate
    
    func didSelect(pokemon: URL) {
        self.openPokemonDetail(pokemon: pokemon)
    }
}
