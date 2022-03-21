import UIKit
import RxSwift

class PokemonsListController: UIViewController, RootViewGettable {
    
    // MARK: -
    // MARK: Type inferences
    
    typealias RootView = PokemonsListView
    
    // MARK: -
    // MARK: Variables
    
    let requester: Requester
    
    // MARK: -
    // MARK: Initializators
    
    init(requester: Requester){
        self.requester = requester
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -
    // MARK: Public functions
    
    public func sendToPrint(data: [String]) {
        DispatchQueue.main.async {
            self.rootView?.print(data)
        }
    }
    
    func pokemonsNames() {
        self.requester.pokemons(limit: 20) { response in
            switch response {
            case .success(let data):
                self.sendToPrint(data: data.map { $0.name })
            case .failure(_):
                print("Incorrect response from server")
            }
        }
    }
    
    // MARK: -
    // MARK: ViewController Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.rootView?.prepare(with: self)
        self.pokemonsNames()
    }
}
