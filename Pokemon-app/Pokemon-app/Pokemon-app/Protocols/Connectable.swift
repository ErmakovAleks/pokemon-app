import UIKit

protocol Connectable {
    
    var coordinator: AppCoordinator? { get }
    
    static func createObject() -> Self
}
