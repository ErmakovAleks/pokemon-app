import Foundation
import RxSwift

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
    
    func pokemonImage(number: Int, handler: ((UIImage) -> ())) {
//        var request = URLRequest(url: URL(string: "https://pokeapi.co/api/v2/pokemon/\(number)/")!)
//        request.httpMethod = "GET"
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            if let data = data, let image = try? JSONDecoder().decode(UIImage.self, from: data) {
//                handler(.success(image))
//            }
//            if let error = error {
//                handler(.failure(error))
//            }
//        }
//        task.resume()
        let imageURL = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(number + 1).png")
        print("URL is \(imageURL)")
        guard let data = try? Data(contentsOf: imageURL!),
              let image = UIImage(data: data) else { return }
        handler(image)
    }
}
