import Foundation
import UIKit

class MainCoordinator<Service: PokemonsDataProvider>: BaseCoordinator, PokemonsListDelegate where Service: NSObject {
    
    // MARK: -
    // MARK: Associated Types
    
    typealias NetworkService = Service
    
    // MARK: -
    // MARK: Public variables
    
    let provider = NetworkService()
    
    // MARK: -
    // MARK: BaseCoordinator functions
    
    override func start() {
        let viewController = PokemonsListController(provider: self.provider)
        viewController.events.bind {
            switch $0 {
            case .showDetails(url: let url):
                self.didSelect(pokemon: url)
            }
        }
        .disposed(by: viewController.disposeBag)
        self.pushViewController(viewController, animated: true)
    }
    
    // MARK: -
    // MARK: Private functions
    
    private func openPokemonDetail(pokemon: URL) {
        let pokemonDetail = PokemonDetailController(provider: self.provider, url: pokemon)
        self.pushViewController(pokemonDetail, animated: true)
    }
    
    // MARK: -
    // MARK: PokemonsListDelegate
    
    func didSelect(pokemon: URL) {
        self.openPokemonDetail(pokemon: pokemon)
    }
}
