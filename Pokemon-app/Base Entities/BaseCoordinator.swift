import Foundation
import UIKit

class BaseCoordinator: UINavigationController {
    
    func start() {}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.start()
    }
}
