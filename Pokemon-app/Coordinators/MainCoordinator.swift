import Foundation
import UIKit

class MainCoordinator: BaseCoordinator, PokemonsListDelegate {
    
    // MARK: -
    // MARK: Variables
    
    let provider: PokemonsDataProvidable
    
    // MARK: -
    // MARK: Initializators
    
    init(provider: PokemonsDataProvidable) {
        self.provider = provider
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
