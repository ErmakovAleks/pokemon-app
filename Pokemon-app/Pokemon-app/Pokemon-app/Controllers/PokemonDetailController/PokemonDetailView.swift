import Foundation
import UIKit

class PokemonDetailView: UIView, ControllerPreparable {
    
    // MARK: -
    // MARK: Type Inferences
    
    typealias T = PokemonDetailController
   
    // MARK: -
    // MARK: IBOutlets
    
    @IBOutlet var pokemonNameLabel: UILabel?
    @IBOutlet var pokemonHeightLabel: UILabel?
    @IBOutlet var pokemonWeightLabel: UILabel?
    @IBOutlet var pokemonImage: UIImageView?
    
    // MARK: -
    // MARK: Public variables
    
    var controller: PokemonDetailController?
}
