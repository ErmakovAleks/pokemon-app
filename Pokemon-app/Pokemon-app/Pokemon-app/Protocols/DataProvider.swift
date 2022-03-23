import Foundation

protocol DataProvider {
    
    associatedtype Element
    
    func data(count: Int, closure: @escaping (Result<Array<Element>, Error>) -> ())
}
