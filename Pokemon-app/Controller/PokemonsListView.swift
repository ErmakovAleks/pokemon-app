import UIKit

class PokemonsListView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: -
    // MARK: Associated Types
    
    typealias commonType<T> = (T) -> ()
    
    // MARK: -
    // MARK: IBOutlets
    
    @IBOutlet var tableView: UITableView?
    
    // MARK: -
    // MARK: Variables
    
    private weak var controller: PokemonsListController?
    public var names = [String]()
    
    // MARK: -
    // MARK: Public functions
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func prepare(with controller: PokemonsListController) {
        self.controller = controller
    }
    
    func print( _ data: [String]) -> () {
        self.names = data
        self.tableView?.reloadData()
    }
    
    // MARK: -
    // MARK: UITableViewDelegate, UITableViewDataSource
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = names[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
}
