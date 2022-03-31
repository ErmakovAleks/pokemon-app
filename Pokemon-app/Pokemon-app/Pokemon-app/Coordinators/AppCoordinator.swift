import Foundation
import UIKit

class AppCoordinator: Coordinator {
    
    // MARK: -
    // MARK: Public variables
    
    var navigationController: UINavigationController
    
    // MARK: -
    // MARK: Initializators
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = PokemonsListController.createObject()
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func openPokemonDetailsVC() {
        let pokemonDetailsVC = PokemonDetailsViewController()
        pokemonDetailsVC.coordinator = self
        navigationController.pushViewController(pokemonDetailsVC, animated: true)
    }
}
