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
    
    public var numberOfNames: Int?
    public var namesArray = [String]()
    private weak var controller: ViewController?
    
    // MARK: -
    // MARK: Public functions
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func prepare(with controller: ViewController) {
        self.controller = controller
    }
    
    func printList( _ listOfNames: Result<[String], Error>) -> () {
        
        switch listOfNames {
        case .success(let names):
            self.namesArray = names
            print("<!> Data is received!")
            self.tableView?.reloadData()
        case .failure(_):
            print("Incorrect response from server")
        }
    }
    
    // MARK: -
    // MARK: UITableViewDelegate, UITableViewDataSource
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = namesArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return namesArray.count
    }
    
}
