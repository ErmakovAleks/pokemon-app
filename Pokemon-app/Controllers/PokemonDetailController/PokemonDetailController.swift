import UIKit

class PokemonDetailController: BaseViewController<PokemonDetailView, PokemonsEvents> {
    
    // MARK: -
    // MARK: Variables
    
    private var name: String?
    private var height: Int?
    private var weight: Int?
    private var image: UIImage?
    
    private let url: URL?
    private let provider: PokemonsDataProvidable
    
    // MARK: -
    // MARK: Initializators
    
    init(provider: PokemonsDataProvidable, url: URL?){
        self.url = url
        self.provider = provider
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -
    // MARK: Public functions
    
    public func showDetails() {
        guard let url = self.url else { return }
        
        self.provider
            .details(url: url)
            .subscribe (
                onSuccess: { details in
                if let url = details.sprites?.frontDefault {
                    self.provider.pokemonImage(url: url, handler: { [weak self] img in
                        self?.refresh(details: details, image: img)
                    })
                }
                }, onFailure: { _ in
            print("Incorrect response from server")
        })
            .disposed(by: self.disposeBag)
    }
    
    // MARK: -
    // MARK: Private functions
    
    private func refresh(details: PokemonDetails, image: UIImage?) {
        self.name = details.name
        self.height = details.height
        self.weight = details.weight
        self.image = image
        
        DispatchQueue.main.async {
            self.rootView?.pokemonNameLabel?.text = self.name
            if let height = self.height, let weight = self.weight {
                self.rootView?.pokemonHeightLabel?.text = "Height: \(height) inches"
                self.rootView?.pokemonWeightLabel?.text = "Weight: \(weight) gramms"
            }
            self.rootView?.pokemonImage?.image = self.image
        }
    }
    
    // MARK: -
    // MARK: ViewController Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.showDetails()
    }
}
