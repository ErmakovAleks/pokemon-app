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
    
    func printList( _ listOfNames: [String]) -> () {
        var allNamesString = ""
        for name in listOfNames {
            allNamesString += name + ", "
        }
        pokemonsNames?.text = allNamesString
    }
}
