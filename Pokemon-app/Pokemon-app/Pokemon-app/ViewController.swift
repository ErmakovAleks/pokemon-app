//
//  ViewController.swift
//  Pokemon-app
//
//  Created by Александр Ермаков on 04.02.2022.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: -
    // MARK: Public variables
    
    var requester = Requester()
    
    // MARK: -
    // MARK: Public functions
    
    public func printData(data: [String]) {
        print("<!>Test2")
        print(data)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requester.printTest()
        requester.getPokemonsNames(limit: 10, completion: (requester.didReceiveData)!)
        requester.didReceiveData = { [weak self] data in
            self?.printData(data: data)
        }
    }
    
}

