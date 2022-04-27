import UIKit

class PokemonDetailController: UIViewController, RootViewGettable, Connectable {
    
    // MARK: -
    // MARK: Type inferences
    
    typealias RootView = PokemonDetailView
    
    // MARK: -
    // MARK: Variables
    
    weak var coordinator: MainCoordinator?
    private var name: String?
    private var height: Int?
    private var weight: Int?
    private var image: UIImage?
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
    
    public func showDetails(url: URL) {
        self.provider.details(url: url) { [weak self] response in
            switch response {
            case .success(let details):
                self?.refresh(details: details)
            case .failure(_):
                print("Incorrect response from server")
            }
        }
    }
    
    // MARK: -
    // MARK: Private functions
    
    private func refresh(details: Detail) {
        self.name = details.name
        self.height = details.height
        self.weight = details.weight
        
        if let name = self.name, let height = self.height,
           let weight = self.weight {
            self.rootView?.pokemonNameLabel?.text = name
            self.rootView?.pokemonHeightLabel?.text = "Height: \(height) inches"
            self.rootView?.pokemonWeightLabel?.text = "Weight: \(weight) gramms"
            //self.rootView?.pokemonImage?.image = image
        }
    }
    
    // MARK: -
    // MARK: ViewController Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.rootView?.prepare(with: self)
    }
}
