import Foundation
import UIKit

protocol BaseView: UIView {
    
    associatedtype T
    
    var controller: T? { get set }
}

extension BaseView {
    
    func prepare(with controller: UIViewController) {
        self.controller = controller as? Self.T
    }
}
