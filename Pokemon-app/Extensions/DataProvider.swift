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
        let url = URL(string: self.linkEntry + "?limit=\(limit)&offset=\(offset)")!
        if let pokemons = self.cache.pokemonsCache.object(forKey: url.absoluteString as NSString) {
            print("Cached!")
            return pokemons.value
        } else {
            print("Downloaded!")
            let pokemons = self.innerProvider.list(limit: limit, offset: offset)
            self.cache.addToCache(notObject: pokemons, url: url)
            return pokemons
        }
    }
    
    func details(url: URL) -> Single<Detail> {
        if let details = self.cache.detailsCache.object(forKey: url.absoluteString as NSString) {
            print("Cached!")
            return details.value
        } else {
            print("Downloaded!")
            let details = self.innerProvider.details(url: url)
            self.cache.addToCache(notObject: details, url: url)
            return details
        }
    }
    
    
    
}
