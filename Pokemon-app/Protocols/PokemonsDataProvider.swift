import Foundation
import UIKit
import RxSwift
import RxCocoa

// MARK: -
// MARK: Enums

enum PokemonAPI: String {
    
    case dev = "https://pokeapi.co/api/v2/pokemon/"
    case prod = "https://another-link"
    
    
    static func environment() -> String {
        #if DEBUG
        return PokemonAPI.dev.rawValue
        #else
        return PokemonAPI.prod.rawValue
        #endif
    }
}

enum Errors: Error {
    case notValidUrl
}

// MARK: -
// MARK: Provider Requirements Protocol

protocol PokemonsDataProvider {
    
    var linkEntry: String { get }
    
    func list(limit: Int, offset: Int) -> Single<[Pokemon]>
    
    func details(url: URL) -> Single<PokemonDetails>
    
    func pokemonImage(url: URL, handler: @escaping ((UIImage?) -> Void))
}

extension PokemonsDataProvider {
    
    func pokemonImage(url: URL, handler: @escaping ((UIImage?) -> Void)) {
        var image: UIImage?
        if let data = try? Data(contentsOf: url) {
            image = UIImage(data: data)
        }
        handler(image)
    }
}
