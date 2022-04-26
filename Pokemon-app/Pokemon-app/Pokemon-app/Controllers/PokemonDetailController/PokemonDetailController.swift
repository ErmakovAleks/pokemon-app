import UIKit

class PokemonDetailController: UIViewController, RootViewGettable, Connectable {
    
    // MARK: -
    // MARK: Type inferences
    
    typealias RootView = PokemonDetailView
    
    // MARK: -
    // MARK: Variables
    
    weak var coordinator: MainCoordinator?
    public var name: String?
    let provider: PokemonsDataProvider
    
    // MARK: -
    // MARK: Initializators
    
    init(provider: PokemonsDataProvider){
        self.provider = provider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -
    // MARK: Public functions

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.rootView?.prepare(with: self)
        //changeName()
    }
    
    public func showDetails(name: String, number: Int) {
        changeName(name: name)
        changeImage(number: number)
    }
    
    private func changeName(name: String) {
        self.name = name
        self.rootView?.pokemonNameLabel?.text = self.name
    }
    
    private func changeImage(number: Int) {
        self.provider.pokemonImage(number: number) { image in
            self.rootView?.pokemonImage?.image = image
        }
    }
}
