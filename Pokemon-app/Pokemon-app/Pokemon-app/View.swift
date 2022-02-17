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
    
    @IBOutlet var pokemonsNames: UITextField?
    
    // MARK: -
    // MARK: Public functions
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func printList( _ listOfNames: Result<[String], IncorrectResponseError, EmptyArrayError>) -> () {
        switch listOfNames {
        case .success(let names):
            var allNamesString = ""
            for name in names {
                allNamesString += name + ", "
            }
            pokemonsNames?.text = allNamesString
        case .failure(_):
            print("Incorrect response from server")
        case .empty(_):
            print("There is no pokemons names")
        }
    }
}
