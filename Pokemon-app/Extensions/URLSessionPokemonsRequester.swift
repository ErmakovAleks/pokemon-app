import Foundation
import RxSwift
import UIKit

enum PokemonAPI: String {
    case dev = "https://pokeapi.co/api/v2/pokemon/"
}

// MARK: -
// MARK: Public class

public class URLSessionPokemonsRequester: PokemonsDataProvider {
    
    // MARK: -
    // MARK: Public functions
    
    func list(limit: Int = 20, offset: Int = 0) -> Single<[Pokemon]> {
        let url = URL(string: PokemonAPI.dev.rawValue + "?limit\(limit)&offset\(offset)")!
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
    
    func details(url: URL) -> Single<Detail> {
        return Single<Detail>.create { single in
            self.commonRequest(url: url) { (results: Result<PokemonDetails, Error>) in
                switch results {
                case .success(let results):
                    guard let imageURL = results.sprites?.frontDefault else { return }
                    let image: UIImage? = self.pokemonImage(url: imageURL)
                    let details: Detail = (
                        name: results.name,
                        height: results.height,
                        weight: results.weight,
                        image: image
                    )
                    single(.success(details))
                case .failure(let error):
                    single(.failure(error))
                }
            }
            return Disposables.create()
        }
    }
    
    // MARK: -
    // MARK: Private functions
    
    private func pokemonImage(url: URL) -> UIImage? {
        let imageURL = url
        guard let data = try? Data(contentsOf: imageURL),
              let image = UIImage(data: data) else { return nil }
        return image
    }
    
    private func commonRequest<T: Codable>(url: URL, handler: @escaping (Result<T, Error>) -> ()) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data,
               let results = try? JSONDecoder().decode(T.self, from: data) {
                handler(.success(results))
            }
            if let error = error {
                handler(.failure(error))
            }
        }
        task.resume()
    }
}
