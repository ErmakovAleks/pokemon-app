import Foundation

protocol PokemonsDataProvider {
    
    func data(count: Int, completion: @escaping (Result<Array<Pokemon>, Error>) -> ())
}
