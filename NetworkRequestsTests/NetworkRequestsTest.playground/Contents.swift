import Cocoa
import Foundation

var request = URLRequest(url: URL(string: "https://pokeapi.co/api/v2/pokemon/?limit=1118")!)
request.httpMethod = "GET"

let task = URLSession.shared.dataTask(with: request) { data, response, error in
    var namesArray: [String] = []
    if let data = data, let pokemons = try? JSONDecoder().decode(Pokemons.self, from: data), let results = pokemons.results {
        for result in results {
            namesArray.append(result.name!)
        }
    }
    print(namesArray.sorted {$0 < $1})
}.resume()
