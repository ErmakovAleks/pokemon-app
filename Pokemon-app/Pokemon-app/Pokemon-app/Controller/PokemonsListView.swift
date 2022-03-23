import UIKit

class View: UIView, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: -
    // MARK: IBOutlets
    
    @IBOutlet var tableView: UITableView?
    
    // MARK: -
    // MARK: Public variables
    
    private weak var controller: PokemonsListController?
    
    // MARK: -
    // MARK: Public functions
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func prepare(with controller: PokemonsListController) {
        self.controller = controller
    }
    
    // MARK: -
    // MARK: UITableViewDelegate, UITableViewDataSource
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = self.controller?.names[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let controller = self.controller else { return 0 }
        return controller.names.count
    }
}
