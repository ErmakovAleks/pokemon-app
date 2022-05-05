import UIKit

class PokemonsListView: UIView, UITableViewDelegate, UITableViewDataSource, ControllerPreparable {

    // MARK: -
    // MARK: Type Inferences
    
    typealias T = PokemonsListController
    
    // MARK: -
    // MARK: IBOutlets
    
    @IBOutlet var tableView: UITableView?
    
    // MARK: -
    // MARK: Public variables
    
    var controller: PokemonsListController?
    
    // MARK: -
    // MARK: Public functions
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.controller?.detailsURL(cellNumber: indexPath.row)
    }
    
    // MARK: -
    // MARK: UITableViewDelegate, UITableViewDataSource
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = self.controller?.pokemons[indexPath.row].name
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let controller = self.controller else { return 0 }
        return controller.pokemons.count
    }
}
