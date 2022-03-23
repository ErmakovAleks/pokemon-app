import Foundation
import RxSwift

// MARK: -
// MARK: Public class

public class URLSessionPokemonsRequester: PokemonsDataProvider {
    
    // MARK: -
    // MARK: Public functions
    
    func data(count: Int, completion: @escaping (Result<Array<Pokemon>, Error>) -> ()) {
        self.pokemons(limit: count, completion: completion)
    }
    
    func pokemons(limit: Int = 20, completion: @escaping PokemonsCardsCompletion) {
        self.task(limit: limit, handler: completion)
    }
    
    public func names(limit: Int = 20) -> Single<[Pokemon]> {
        return Single<[Pokemon]>.create { single in
            self.task(limit: limit) { results in
                switch results {
                case .success(let pokemons):
                    single(.success(pokemons))
                case .failure(let error):
                    single(.failure(error))
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
