import UIKit
import RxSwift

class PokemonsListController: UIViewController, RootViewGettable, Connectable {
    
    // MARK: -
    // MARK: Type inferences
    
    typealias RootView = PokemonsListView
    
    // MARK: -
    // MARK: Variables
    
    let provider: PokemonsDataProvider
    weak var coordinator: AppCoordinator?
    var names = [String]()
    
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
    
    public func sendToPrint(data: [String]) {
        DispatchQueue.main.async {
            self.names = data
            self.rootView?.tableView?.reloadData()
        }
    }
    
    func pokemonsNames() {
        self.provider.data(count: 10) { response in
            switch response {
            case .success(let data):
                self.sendToPrint(data: data.map { $0.name })
            case .failure(_):
                print("Incorrect response from server")
            }
        }
    }
    
    static func createObject() -> Self {
        let requester = URLSessionPokemonsRequester()
        return PokemonsListController(provider: requester) as! Self
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
