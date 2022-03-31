import UIKit

class PokemonDetailsViewController: UIViewController, Connectable {
    
    // MARK: -
    // MARK: Type inferences
    
    typealias RootView = PokemonDetailsView
    
    // MARK: -
    // MARK: Outlets
    
    @IBOutlet weak var pokemonNameLabel: UILabel?
    
    // MARK: -
    // MARK: Variables
    
    weak var coordinator: AppCoordinator?
    
    // MARK: -
    // MARK: Public functions

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "PokemonDetailsVC"
    }
    
    static func createObject() -> Self {
        return PokemonDetailsViewController() as! Self
    }
}
