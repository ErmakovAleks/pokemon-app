import Foundation
import RxSwift
import UIKit

// MARK: -
// MARK: Public class

public class URLSessionPokemonsRequester: PokemonsDataProvidable {
    
    // MARK: -
    // MARK: Variables
    
    var linkEntry: String = PokemonAPI.environment()
    
    // MARK: -
    // MARK: Public functions
    
    func list(limit: Int = 20, offset: Int = 0) -> Single<[Pokemon]> {
        guard let url = URL(string: self.linkEntry + "?limit=\(limit)&offset=\(offset)") else {
            return .error(Errors.notValidUrl)
        }
        
        return Single<[Pokemon]>.create { single in
            self.commonRequest(url: url) { (results: Result<Pokemons, Error>) in
                switch results {
                case .success(let pokemons):
                    guard let results = pokemons.results else { return }
                    single(.success(results))
                case .failure(let error):
                    single(.failure(error))
                }
            }
            return Disposables.create()
        }
    }
    
    func details(url: URL) -> Single<PokemonDetails> {
        return Single<PokemonDetails>.create { single in
            self.commonRequest(url: url) { (results: Result<PokemonDetails, Error>) in
                switch results {
                case .success(let results):
                    single(.success(results))
                case .failure(let error):
                    single(.failure(error))
                }
            }
            return Disposables.create()
        }
    }
    
    // MARK: -
    // MARK: Private functions
    
    private func commonRequest<T: Codable>(url: URL, handler: @escaping (Result<T, Error>) -> ()) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data,
               let results = try? JSONDecoder().decode(T.self, from: data) {
                handler(.success(results))
            } else { print("Invalid response!") }
            if let error = error {
                handler(.failure(error))
            }
        }
        task.resume()
    }
}
