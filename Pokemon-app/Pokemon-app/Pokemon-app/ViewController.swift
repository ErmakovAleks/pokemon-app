//
//  ViewController.swift
//  Pokemon-app
//
//  Created by Александр Ермаков on 04.02.2022.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    
    // MARK: -
    // MARK: Public variables
    
    let requester: Requester
    
    // MARK: -
    // MARK: Initializators
    
    init(requester: Requester){
        self.requester = requester
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -
    // MARK: Public functions
    
    public func printData(data: [String]) {
        DispatchQueue.main.async {
            (self.view as? View)?.printList(data)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.requester.didReceiveData = { [weak self] data in
            self?.printData(data: data)
        }
        self.requester.getPokemonsNames(limit: 10)
    }
}
