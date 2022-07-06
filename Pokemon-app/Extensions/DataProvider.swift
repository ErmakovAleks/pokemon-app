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
    var storage: PokemonsStorageProvider
    
    // MARK: -
    // MARK: Initializators
    
    init(innerProvider: PokemonsDataProvider, cache: PokemonsCacheble, storage: PokemonsStorageProvider) {
        self.innerProvider = innerProvider
        self.cache = cache
        self.storage = storage
    }
    
    // MARK: -
    // MARK: Private Functions
    
    private func single(from offset: Int) -> Single<[Pokemon]> {
        return Single<[Pokemon]>.create { single in
            let pokemons = self.storage.fetchFromCoreData(offset: offset, limit: 20)
            single(.success(pokemons))
            return Disposables.create()
        }
    }
    
    // MARK: -
    // MARK: PokemonsDataProvider Functions
    
    func list(limit: Int, offset: Int) -> Single<[Pokemon]> {
        if let count = self.storage.count(), offset >= count {
            let pokemons = self.innerProvider.list(limit: limit, offset: offset)
            return pokemons
                .map { self.storage.saveToCoreData(array: $0) }
                .flatMap { self.single(from: offset) }
        } else {
            return Single<[Pokemon]>.create { single in
                let pokemons = self.storage.fetchFromCoreData(offset: offset, limit: limit)
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
