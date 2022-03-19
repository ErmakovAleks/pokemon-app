import Foundation
import RxSwift

// MARK: -
// MARK: Public class

public class Requester {
    
    // MARK: -
    // MARK: Associated Types
    
    typealias Completion<T> = (Result<T, Error>) -> ()
    typealias PokemonsCardsCompletion = Completion<[Pokemon]>
    
    // MARK: -
    // MARK: Public Enums
    
    enum UnexpectedError: Error {
        case unexpectedError
    }
    
    // MARK: -
    // MARK: Public initializations
    
    public init() {}
    
    // MARK: -
    // MARK: Public functions
    
    func pokemons(limit: Int = 20, completion: @escaping (Result<[Pokemon], Error>) -> ()) {
        task(limit: limit, handler: completion)
    }
    
    public func names(limit: Int = 20) -> Observable<String> {
        return Observable<String>.create { observer in
            self.task(limit: limit) { results in
                switch results {
                case .success(let pokemons):
                    pokemons.map { observer.onNext($0.name) }
                case .failure(_):
                    return
                }
            }
            return Disposables.create()
        }
    }
    
    private func task(limit: Int, handler: @escaping PokemonsCardsCompletion) {
        var request = URLRequest(url: URL(string: "https://pokeapi.co/api/v2/pokemon/?limit=\(limit)")!)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data, let pokemons = try? JSONDecoder().decode(Pokemons.self, from: data),
               let results = pokemons.results {
                handler(.success(results))
            }
            if let error = error {
                handler(.failure(error))
            }
        }
        task.resume()
    }
}
