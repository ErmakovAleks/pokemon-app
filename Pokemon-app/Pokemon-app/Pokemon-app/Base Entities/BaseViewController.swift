import Foundation
import UIKit
import RxSwift
import RxCocoa

// MARK: -
// MARK: Events Enumeration

public enum PokemonsEvents {
    case showDetails(url: URL)
}

class BaseViewController<ViewType: BaseView>: UIViewController, RootViewGettable {
    
    // MARK: -
    // MARK: Type Inferences
    
    typealias RootView = ViewType
    
    // MARK: -
    // MARK: Public variables
    
    public let events = PublishSubject<PokemonsEvents>()
    public let disposeBag = DisposeBag()
    
    // MARK: -
    // MARK: ViewController Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.rootView?.prepare(with: self)
    }
}
