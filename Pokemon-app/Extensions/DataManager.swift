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

class DataManager: PokemonsDataProvidable {
    
    // MARK: -
    // MARK: Variables
    
    var linkEntry: String = PokemonAPI.environment()
    var innerProvider: PokemonsDataProvidable
    var cache: PokemonsCacheble
    var storage: PokemonsPersistenceProvidable
    
    // MARK: -
    // MARK: Initializators
    
    init(innerProvider: PokemonsDataProvidable, cache: PokemonsCacheble, storage: PokemonsPersistenceProvidable) {
        self.innerProvider = innerProvider
        self.cache = cache
        self.storage = storage
    }
    
    // MARK: -
    // MARK: Private Functions
    
    private func singlePokemons(from offset: Int, limit: Int) -> Single<[Pokemon]> {
        return Single<[Pokemon]>.create { single in
            let pokemons = self.storage.pokemons(offset: offset, limit: 20)
            switch pokemons {
            case .success(let result):
                single(.success(result))
            case .failure(let error):
                single(.failure(error))
            }
            return Disposables.create()
        }
    }
    
    private func singleDetails(for url: URL) -> Single<PokemonDetails> {
        return Single<PokemonDetails>.create { single in
            let details = self.storage.details(for: url)
            switch details {
            case .success(let result):
                single(.success(result))
            case .failure(let error):
                single(.failure(error))
            }
            return Disposables.create()
        }
    }
    
    // MARK: -
    // MARK: PokemonsDataProvider Functions
    
    func list(limit: Int, offset: Int) -> Single<[Pokemon]> {
        if let count = self.storage.count(), offset >= count {
            let pokemons = self.innerProvider.list(limit: limit, offset: offset)
            
            return pokemons.map { self.storage.save(array: $0) { poks in
                switch poks {
                case .success:
                    break
                case .failure(let error):
                    print(error)
                }
            }}.flatMap { self.singlePokemons(from: offset, limit: limit) }
        } else {
            return self.singlePokemons(from: offset, limit: limit)
        }
    }
    
    func details(url: URL) -> Single<PokemonDetails> {
        if self.storage.containsPokemon(for: url) {
            return self.singleDetails(for: url)
        } else {
            let details = self.innerProvider.details(url: url)
            
            return details.map { self.storage.save(details: $0, url: url) { detail in
                switch detail {
                case .success:
                    break
                case .failure(let error):
                    print(error)
                }
            }
            }.flatMap { self.singleDetails(for: url) }
        }
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
