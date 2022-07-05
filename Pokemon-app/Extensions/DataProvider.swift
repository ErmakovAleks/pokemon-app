//
//  DataProvider.swift
//  Pokemon-app
//
//  Created by Александр Ермаков on 09.06.2022.
//

import Foundation
import RxSwift
import UIKit
import CoreData

class DataProvider: PokemonsDataProvider {
    
    // MARK: -
    // MARK: Variables
    
    var linkEntry: String = PokemonAPI.environment()
    var innerProvider: PokemonsDataProvider
    var cache: PokemonsCacheble
    var coreData: PokemonsCoreDataProvider
    
    // MARK: -
    // MARK: Initializators
    
    init(innerProvider: PokemonsDataProvider, cache: PokemonsCacheble, coreData: PokemonsCoreDataProvider) {
        self.innerProvider = innerProvider
        self.cache = cache
        self.coreData = coreData
    }
    
    // MARK: -
    // MARK: PokemonsDataProvider Functions
    
    func list(limit: Int, offset: Int) -> Single<[Pokemon]> {
        if limit + offset > self.coreData.fetchFromCoreData().count {
            let pokemons = self.innerProvider.list(limit: limit, offset: offset)
            pokemons.subscribe(
                onSuccess: { [weak self] response in
                    self?.coreData.saveToCoreData(array: response)
                }, onFailure: { _ in
                    print("Incorrect response from server")
                })
            return pokemons
        } else {
            return Single<[Pokemon]>.create { single in
                let pokemons = self.coreData.fetchFromCoreData()
                single(.success(pokemons))
                return Disposables.create()
            }
        }
    }
    
    func details(url: URL) -> Single<PokemonDetails> {
        let details = self.innerProvider.details(url: url)
        return details
    }
    
    func pokemonImage(url: URL, handler: @escaping ((UIImage?) -> Void)) {
        if let image = self.cache.checkCache(url: url) {
            handler(image)
        } else {
            DispatchQueue.global(qos: .background).async {
                if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                    self.cache.addToCacheFolder(image: image, url: url)
                    handler(image)
                } else { handler(nil) }
            }
        }
    }
}
