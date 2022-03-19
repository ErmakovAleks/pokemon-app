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

let pokemonsNames = getPokemonsNames(limit: 10, completion: {results in
    pokemonView.pokemonNames = results
})

let countryCodes = ["Arendelle": "AR", "Genovia": "GN", "Freedonia": "FD"]
let countryCode = countryCodes["Freedonia"]
print(countryCode)



struct Food { // struct Pokemon/Pokemons
    
    let calories: Int
}

protocol FoodProvider {
    
    func food() -> Food
}

class Human {
    
    func eatSomething(from provider: FoodProvider) {
        print("I eat ", provider.food().calories)
    }
}

class Delivery: FoodProvider { //PokemonTableHandler
    
    let adress: String
    init(adress: String) {
        self.adress = adress
    }
    
    func food() -> Food {
        let food = Food(calories: 1000)
        
        print("delivered to adress: ", self.adress)
        
        return food
    }
}

class Kitchen: FoodProvider { //PokemonTableHandler
    
    let human: Human
    init(human: Human) {
        self.human = human
    }
    
    func food() -> Food {
        let food = Food(calories: 500)
        
        print("Food cooked by", self.human)
        
        return food
    }
}

class Main {  //AppDelegate
    
    func main() {
        let human = Human()
        
        let rocket = Delivery(adress: "Gagarina str.")
        human.eatSomething(from: rocket)
        
        let kitchen = Kitchen(human: human)
        human.eatSomething(from: kitchen)
    }
}

var main = Main()
main.main()
