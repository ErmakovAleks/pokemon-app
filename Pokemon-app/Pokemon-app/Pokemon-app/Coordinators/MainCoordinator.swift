import Foundation
import UIKit

class MainCoordinator: Coordinator {
    
    // MARK: -
    // MARK: Public variables
    
    var navigationController: UINavigationController
    public var nameCompletion: ((String) -> ())?
    
    // MARK: -
    // MARK: Initializators
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let requester = URLSessionPokemonsRequester()
        let viewController = PokemonsListController(provider: requester)
        viewController.coordinator = self
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func openPokemonDetail(name: String, number: Int) {
        let requester = URLSessionPokemonsRequester()
        let pokemonDetail = PokemonDetailController(provider: requester)
        pokemonDetail.coordinator = self
        pokemonDetail.showDetails(name: name, number: number)
        self.navigationController.pushViewController(pokemonDetail, animated: true)
    }
}
