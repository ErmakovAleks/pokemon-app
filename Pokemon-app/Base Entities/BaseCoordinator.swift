import Foundation
import UIKit

class BaseCoordinator: UINavigationController {
    
    // MARK: -
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.start()
    }
    
    // MARK: -
    // MARK: Overriding
    
    func start() {}
}
