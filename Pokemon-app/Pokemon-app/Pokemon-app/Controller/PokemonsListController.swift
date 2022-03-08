//
//  ViewController.swift
//  Pokemon-app
//
//  Created by Александр Ермаков on 04.02.2022.
//

import UIKit
import RxSwift

class PokemonsListController: UIViewController, RootViewGettable {
    
    // MARK: -
    // MARK: Type inferences
    
    typealias RootView = View
    
    // MARK: -
    // MARK: Variables
    
    let requester: Requester
    var numberOfNames: ((Int) -> ())?
    var arrayOfNames: (([String]) -> ())?
    
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
    
    public func sendToPrint(data: [String]) {
        DispatchQueue.main.async {
            self.rootView?.print(data)
        }
    }
    
    func pokemonsNames() {
        self.requester.pokemons(limit: 20) { response in
            switch response {
            case .success(let data):
                var names = [String]()
                for pokemonCard in data {
                    if let name = pokemonCard.name {
                        names.append(name)
                    }
                }
                self.sendToPrint(data: names)
            case .failure(_):
                print("Incorrect response from server")
            }
        }
    }
    
    // MARK: -
    // MARK: ViewController Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.rootView?.prepare(with: self)
        self.pokemonsNames()
    }
}
