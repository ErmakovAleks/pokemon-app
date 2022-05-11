import UIKit
import RxSwift

class PokemonsListController: BaseViewController<PokemonsListView> {
    
    // MARK: -
    // MARK: Variables
    
    let provider: PokemonsDataProvider
    weak var pokemonsListDelegate: PokemonsListDelegate?
    var pokemons = [Pokemon]()
    
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
    
    public func sendToPrint(data: [Pokemon]) {
        DispatchQueue.main.async {
            self.pokemons = data
            self.rootView?.tableView?.reloadData()
        }
    }
    
    func pokemonsNames() {
        self.provider.list(count: 20) { [weak self] response in
            switch response {
            case .success(let data):
                self?.sendToPrint(data: data)
            case .failure(_):
                print("Incorrect response from server")
            }
        }
    }
    
    func processPokemon(cellNumber: Int) {
        let detailsURL = self.pokemons[cellNumber].url
        //self.pokemonsListDelegate?.didSelect(pokemon: detailsURL)
        self.events.onNext(.showDetails(url: detailsURL))
    }
    
    // MARK: -
    // MARK: ViewController Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "List of Pokemons"
        self.pokemonsNames()
    }
}
