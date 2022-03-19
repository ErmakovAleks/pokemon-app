import UIKit

class View: UIView {
    
    // MARK: -
    // MARK: Associated Types
    
    typealias commonType<T> = (T) -> ()
    
    // MARK: -
    // MARK: IBOutlets
    
    @IBOutlet var tableView: UITableView?
    
    // MARK: -
    // MARK: Variables
    
    public var tableHandler = PokemonTableHandler()
    private weak var controller: PokemonsListController?
    
    // MARK: -
    // MARK: Public functions
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func prepare(with controller: PokemonsListController) {
        self.controller = controller
    }
    
    func print( _ data: [String]) -> () {
        self.tableHandler.names = data
        self.tableView?.reloadData()
    }
}
