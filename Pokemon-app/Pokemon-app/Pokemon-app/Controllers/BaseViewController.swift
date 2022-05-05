import Foundation
import UIKit

class BaseViewController<ViewType: ControllerPreparable>: UIViewController, RootViewGettable {
    
    typealias RootView = ViewType
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.rootView?.prepare(with: self)
    }
}
