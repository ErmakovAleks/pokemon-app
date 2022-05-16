import UIKit

class PokemonDetailController: BaseViewController<PokemonDetailView, PokemonsEvents> {
    
    // MARK: -
    // MARK: Variables
    
    private var name: String?
    private var height: Int?
    private var weight: Int?
    private var image: UIImage?
    
    private let url: URL?
    private let provider: PokemonsDataProvider
    
    // MARK: -
    // MARK: Initializators
    
    init(provider: PokemonsDataProvider, url: URL?){
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
//        self.provider.details(url: url) { [weak self] response in
//            switch response {
//            case .success(let details):
//                self?.refresh(details: details)
//            case .failure(_):
//                print("Incorrect response from server")
//            }
//        }
        let details = self.provider.rxDetails(url: url).subscribe { details in
            self.refresh(details: details)
        } onFailure: { _ in
            print("Incorrect response from server")
        }
    }
    
    // MARK: -
    // MARK: Private functions
    
    private func refresh(details: Detail) {
        self.name = details.name
        self.height = details.height
        self.weight = details.weight
        self.image = details.image
        
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
