import UIKit
import RxSwift
import UIScrollView_InfiniteScroll

// MARK: -
// MARK: Events Enumeration

public enum PokemonsEvents {
    case showDetails(url: URL)
}

class PokemonsListController: BaseViewController<PokemonsListView, PokemonsEvents> {
    
    // MARK: -
    // MARK: Variables
    
    let provider: PokemonsDataProvider
    weak var pokemonsListDelegate: PokemonsListDelegate?
    var pokemons = [Pokemon]()
    private let pokemonsPortion = 20
    private var shownPokemons = 0
    
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
            self.pokemons += data
            self.rootView?.tableView?.reloadData()
        }
    }
    
    func pokemonsNames(offset: Int = 0) {
        self.provider
            .list(limit: pokemonsPortion, offset: offset)
            .subscribe(
            onSuccess: { [weak self] response in
                self?.sendToPrint(data: response)
            }, onFailure: { _ in
                print("Incorrect response from server")
            })
            .disposed(by: self.disposeBag)
    }
    
    func processPokemon(cellNumber: Int) {
        let detailsURL = self.pokemons[cellNumber].url
        
        self.events.accept(.showDetails(url: detailsURL))
    }
    
    // MARK: -
    // MARK: ViewController Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "List of Pokemons"
        self.pokemonsNames()
        
        self.rootView?.tableView?.addInfiniteScroll { (tableView) -> Void in
            self.shownPokemons += self.pokemonsPortion
            self.pokemonsNames(offset: self.shownPokemons)
            tableView.finishInfiniteScroll()
        }
    }
}
