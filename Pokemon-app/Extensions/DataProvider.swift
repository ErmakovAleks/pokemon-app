//
//  DataProvider.swift
//  Pokemon-app
//
//  Created by Александр Ермаков on 09.06.2022.
//

import Foundation
import RxSwift
import UIKit

class DataProvider: PokemonsDataProvider {
    
    // MARK: -
    // MARK: Variables
    
    var linkEntry: String = PokemonAPI.environment()
    var innerProvider: PokemonsDataProvider
    var cache: PokemonsCacheble
    
    init(innerProvider: PokemonsDataProvider, cache: PokemonsCacheble) {
        self.innerProvider = innerProvider
        self.cache = cache
    }
    
    // MARK: -
    // MARK: PokemonsDataProvider Functions
    
    func list(limit: Int, offset: Int) -> Single<[Pokemon]> {
            let pokemons = self.innerProvider.list(limit: limit, offset: offset)
            return pokemons
    }
    
    func details(url: URL) -> Single<PokemonDetails> {
        let details = self.innerProvider.details(url: url)
        return details
    }
    
    func pokemonImage(url: URL, handler: @escaping ((UIImage?) -> Void)) {
        if let image = self.cache.checkCache(url: url) {
            print("Cached!")
            handler(image)
        } else {
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                print("Downloaded!")
                self.cache.addToCacheFolder(image: image, url: url)
                handler(image)
            } else { handler(nil) }
        }
    }
}
