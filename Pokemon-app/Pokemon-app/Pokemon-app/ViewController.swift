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

class ViewController: UIViewController, RootViewGettable, UITableViewDelegate, UITableViewDataSource {
    
    typealias RootView = View
    
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
    
    public func printData(data: Result<[String], Error>) {
        DispatchQueue.main.async {
            self.rootView?.printList(data)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.requester.didReceiveData = { [weak self] data in
            self?.printData(data: data)
        }
        self.requester.pokemonsNames(limit: 10)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)
        cell.textLabel?.text = "<!>"
        return cell
    }
}
