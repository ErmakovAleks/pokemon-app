//
//  View.swift
//  Pokemon-app
//
//  Created by Александр Ермаков on 16.02.2022.
//

import UIKit

class View: UIView, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: -
    // MARK: IBOutlets
    
    @IBOutlet var tableView: UITableView?
    
    // MARK: -
    // MARK: Public variables
    
    var cell: UITableViewCell?
    
    public var namesArray = [String]()
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
        //self.namesArray = data
        self.cell?.textLabel?.text = data[indexPath.row]
        self.tableView?.reloadData()
    }
    
    // MARK: -
    // MARK: UITableViewDelegate, UITableViewDataSource
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        //self.cell?.textLabel?.text = namesArray[indexPath.row]
        return self.cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return namesArray.count
    }
}
