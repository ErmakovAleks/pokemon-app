//
//  View.swift
//  Pokemon-app
//
//  Created by Александр Ермаков on 16.02.2022.
//

import UIKit

class View: UIView {
    
    // MARK: -
    // MARK: Public variables
    
    var pokemonsNames = UITableView()
    public var numberOfNames: Int?
    public var namesArray = ["one", "two", "three"]
    
    // MARK: -
    // MARK: Public functions
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return namesArray.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = pokemonsNames.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)
//        cell.textLabel?.text = namesArray[indexPath.row]
//        return cell
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func printList( _ listOfNames: Result<[String], Error>) -> () {
        self.pokemonsNames = UITableView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), style: .plain)
        self.pokemonsNames.delegate = window?.rootViewController
        self.pokemonsNames.dataSource = window?.rootViewController
        
        switch listOfNames {
        case .success(let names):
            self.namesArray = names
        case .failure(_):
            print("Incorrect response from server")
        }
    }
}
