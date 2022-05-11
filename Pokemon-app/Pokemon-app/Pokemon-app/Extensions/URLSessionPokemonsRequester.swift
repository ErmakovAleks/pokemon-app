import Foundation
import RxSwift
import UIKit

// MARK: -
// MARK: Public class

public class URLSessionPokemonsRequester: PokemonsDataProvider {
    
    // MARK: -
    // MARK: Public functions
    
    func list(count: Int, completion: @escaping PokemonsCardsCompletion) {
        self.task(limit: count, handler: completion)
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
    
    func details(url: URL, completion: @escaping PokemonDetailCompletion) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data, let details = try? JSONDecoder().decode(PokemonDetails.self, from: data),
               let name = details.name, let height = details.height, let weight = details.weight,
               let imageURL = details.sprites?.frontDefault {
                var image: UIImage?
                self.pokemonImage(url: imageURL) { pokemonImage in
                    image = pokemonImage
                }
                if let image = image {
                    let pokemonDetails = Detail(name: name, height: height, weight: weight, image: image)
                    completion(.success(pokemonDetails))
                }
            }
            if let error = error {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    // MARK: -
    // MARK: Private functions
    
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
    
    private func pokemonImage(url: URL, handler: ((UIImage) -> ())) {
        let imageURL = url
        guard let data = try? Data(contentsOf: imageURL),
              let image = UIImage(data: data) else { return }
        handler(image)
    }
}
