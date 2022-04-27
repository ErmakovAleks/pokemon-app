import Foundation
import UIKit

class MainCoordinator: Coordinator {
    
    // MARK: -
    // MARK: Public variables
    
    var navigationController: UINavigationController
    public var nameCompletion: ((String) -> ())?
    
    // MARK: -
    // MARK: Initializator
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: -
    // MARK: Public functions
    
    func start() {
        let requester = URLSessionPokemonsRequester()
        let viewController = PokemonsListController(provider: requester)
        viewController.coordinator = self
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func openPokemonDetail(url: URL) {
        let requester = URLSessionPokemonsRequester()
        let pokemonDetail = PokemonDetailController(provider: requester)
        pokemonDetail.coordinator = self
        pokemonDetail.showDetails(url: url)
        self.navigationController.pushViewController(pokemonDetail, animated: true)
    }
}
