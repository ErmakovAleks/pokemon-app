//
//  DataProvider.swift
//  Pokemon-app
//
//  Created by Александр Ермаков on 09.06.2022.
//

import Foundation
import RxSwift
import UIKit

class DataProvider<InnerProvider: PokemonsDataProvider>: PokemonsDataProvider where InnerProvider: NSObject {
    
    // MARK: -
    // MARK: Type Inferences
    
    typealias Provider = InnerProvider
    
    // MARK: -
    // MARK: Variables
    
    var linkEntry: String = PokemonAPI.environment()
    var provider = Provider()
    var pokemonsCache = CacheManager<Single<[Pokemon]>>()
    var detailsCache = CacheManager<Single<Detail>>()
    
    // MARK: -
    // MARK: PokemonsDataProvider Functions
    
    func list(limit: Int, offset: Int) -> Single<[Pokemon]> {
        let url = URL(string: self.linkEntry + "?limit=\(limit)&offset=\(offset)")!
        if let pokemons = self.pokemonsCache.cache.object(forKey: url.absoluteString as NSString) {
            print("Cached!")
            return pokemons.value
        } else {
            print("Downloaded!")
            let pokemons = self.provider.list(limit: limit, offset: offset)
            self.pokemonsCache
                .cache
                .setObject(
                    CacheManager<Single<[Pokemon]>>.intoObject(notObject: pokemons),
                    forKey: url.absoluteString as NSString
                )
            return self.provider.list(limit: limit, offset: offset)
        }
    }
    
    func details(url: URL) -> Single<Detail> {
        if let details = self.detailsCache.cache.object(forKey: url.absoluteString as NSString) {
            print("Cached!")
            return details.value
        } else {
            print("Downloaded!")
            let details = self.provider.details(url: url)
            self.detailsCache
                .cache
                .setObject(
                    CacheManager<Single<Detail>>.intoObject(notObject: details),
                    forKey: url.absoluteString as NSString
                )
            return details
        }
    }
    
    
    
}
