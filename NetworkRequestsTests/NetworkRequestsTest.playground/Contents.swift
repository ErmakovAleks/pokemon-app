import Cocoa
import Foundation

public enum Val {
    case all
    case val(Int)
}

// MARK: -
// MARK: Public functions

class View {
    var pokemonNames: [String] = [] {
        didSet {
            self.showPokemonNames()
        }
    }
    
    func showPokemonNames() {
        print(pokemonNames)
    }
}

var pokemonView = View()


func getPokemonsNames(limit: Int = 20, completion: @escaping ([String]) -> ()) {
    var request = URLRequest(url: URL(string: "https://pokeapi.co/api/v2/pokemon/?limit=\(limit)")!)
    request.httpMethod = "GET"
    var names: [String] = []
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        if let data = data, let pokemons = try? JSONDecoder().decode(Pokemons.self, from: data), let results = pokemons.results {
            results.forEach { result in
                names.append(result.name!)
            }
        }
        completion(names)
    }
    task.resume()
}

let pokemonsNames = getPokemonsNames(limit: 2, completion: {results in
    pokemonView.pokemonNames = results
})

