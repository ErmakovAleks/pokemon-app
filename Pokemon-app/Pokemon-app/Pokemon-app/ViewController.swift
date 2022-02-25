//
//  ViewController.swift
//  Pokemon-app
//
//  Created by Александр Ермаков on 04.02.2022.
//

import UIKit
import RxSwift

protocol RootViewGettable: UIViewController {
    
    associatedtype RootView: UIView
    
    var rootView: RootView? { get }
}

extension RootViewGettable {
    
    var rootView: RootView? {
        self.view as? RootView
    }
}

class ViewController: UIViewController, RootViewGettable {
    
    // MARK: -
    // MARK: Type inferences
    
    typealias RootView = View
    
    // MARK: -
    // MARK: Public variables
    
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
    
    public func printData(data: Result<[String], Error>) {
        DispatchQueue.main.async {
            self.rootView?.printList(data)
            switch data {
            case .success(let names):
                self.numberOfNames?(names.count)
                self.arrayOfNames?(names)
            case .failure(_):
                print()
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.rootView?.prepare(with: self)
        self.requester.didReceiveData = { [weak self] data in
            self?.printData(data: data)
        }
        self.requester.pokemonsNames(limit: 10)
    }
}
