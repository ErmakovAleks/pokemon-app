import Foundation
import UIKit
import RxSwift
import RxCocoa


class BaseViewController<ViewType: BaseView, OutputEvents>: UIViewController, RootViewGettable {
    
    // MARK: -
    // MARK: Type Inferences
    
    typealias RootView = ViewType
    
    // MARK: -
    // MARK: Public variables
    
    public let events = PublishRelay<OutputEvents>()
    public let disposeBag = DisposeBag()
    
    // MARK: -
    // MARK: ViewController Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.rootView?.prepare(with: self)
    }
}
