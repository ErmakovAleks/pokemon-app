import Foundation
import UIKit
import RxSwift
import RxCocoa

// MARK: -
// MARK: Pokemon API

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

// MARK: -
// MARK: Provider Requirements Protocol

protocol PokemonsDataProvider {
    
    var linkEntry: String { get }
    
    func list(limit: Int, offset: Int) -> Single<[Pokemon]>
    
    func details(url: URL) -> Single<Detail>
}
