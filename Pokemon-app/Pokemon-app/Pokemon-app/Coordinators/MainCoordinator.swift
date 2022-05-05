import Foundation
import UIKit

class MainCoordinator: UIViewController, Coordinator, PokemonsListDelegate, PokemonDetailDelegate {
    
    // MARK: -
    // MARK: Public variables
    
    weak var navController: UINavigationController?
    var detailURL: URL?
    let requester = URLSessionPokemonsRequester()
    
    // MARK: -
    // MARK: Initializator
    
    init(navigationController: UINavigationController) {
        self.navController = navigationController
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        self.navController?.pushViewController(viewController, animated: true)
    }
    
    func openPokemonDetail(url: URL) {
        let pokemonDetail = PokemonDetailController(provider: self.requester)
        pokemonDetail.pokemonDetailDelegate = self
        self.navController?.pushViewController(pokemonDetail, animated: true)
    }
    
    // MARK: -
    // MARK: ViewController Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .orange
        
        start()
    }
}
