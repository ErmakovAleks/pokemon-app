import UIKit
import RxSwift

class PokemonsListController: UIViewController, RootViewGettable, Connectable {
    
    // MARK: -
    // MARK: Type inferences
    
    typealias RootView = PokemonsListView
    
    // MARK: -
    // MARK: Variables
    
    let provider: PokemonsDataProvider
    weak var coordinator: MainCoordinator?
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
        self.provider.list(count: 10) { response in
            switch response {
            case .success(let data):
                self.sendToPrint(data: data)
            case .failure(_):
                print("Incorrect response from server")
            }
        }
    }
    
    func showDetails(cellNumber: Int) {
        let name = self.pokemons[cellNumber].name
        self.coordinator?.openPokemonDetail(name: name, number: cellNumber)
        print(self.pokemons[cellNumber].url)
    }
    
    // MARK: -
    // MARK: ViewController Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.rootView?.prepare(with: self)
        self.title = "List of Pokemons"
        self.pokemonsNames()
    }
}
