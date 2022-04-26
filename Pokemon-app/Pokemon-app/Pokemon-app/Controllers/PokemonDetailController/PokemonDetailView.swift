import Foundation
import UIKit

class PokemonDetailView: UIView {
    
    // MARK: -
    // MARK: IBOutlets
    
    @IBOutlet var pokemonNameLabel: UILabel?
    @IBOutlet var pokemonImage: UIImageView?

    // MARK: -
    // MARK: Public variables
    
    private weak var controller: PokemonDetailController?
    
    // MARK: -
    // MARK: Public functions
    
    func prepare(with controller: PokemonDetailController) {
        self.controller = controller
    }
}
