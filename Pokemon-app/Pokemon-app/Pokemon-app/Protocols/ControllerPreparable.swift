import Foundation
import UIKit

protocol ControllerPreparable: UIView {
    
    associatedtype T: UIViewController
    
    var controller: T? { get set }
}

extension ControllerPreparable {
    
    func prepare(with controller: UIViewController) {
        self.controller = controller as? Self.T
    }
}
