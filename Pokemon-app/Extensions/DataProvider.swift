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
    
    // MARK: -
    // MARK: Initializators
    
    init(innerProvider: PokemonsDataProvider, cache: PokemonsCacheble) {
        self.innerProvider = innerProvider
        self.cache = cache
    }
    
    // MARK: -
    // MARK: Private functions
    
    private func saveToCoreData(array: [Pokemon]) {
        print("WORK!")
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        for pokemon in array {
            guard let entity = NSEntityDescription.entity(forEntityName: "PokemonEntity", in: context) else { return }
            let pokemonEntity = NSManagedObject(entity: entity, insertInto: context)
            pokemonEntity.setValue(pokemon.name, forKey: "name")
            pokemonEntity.setValue(pokemon.url.absoluteString, forKey: "url")
            
            do {
                try context.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "PokemonEntity")
        var temp: [NSManagedObject] = []
        do {
            temp = try! context.fetch(fetchRequest)
            print("pokemons.count = \(temp.count)")
        }
    }
    
    private func fetchFromCoreData() -> [Pokemon] {
        var pokemons: [Pokemon] = []
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return [] }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "PokemonEntity")
        
        do {
            pokemons = try context.fetch(fetchRequest) as [Pokemon]
            //print("pokemons.count = \(pokemons.count)")
          } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
          }
        return pokemons
    }
    
    // MARK: -
    // MARK: PokemonsDataProvider Functions
    
    func list(limit: Int, offset: Int) -> Single<[Pokemon]> {
        if limit + offset > self.fetchFromCoreData().count {
            print("Дозагрузка")
            let pokemons = self.innerProvider.list(limit: limit, offset: offset)
            pokemons.subscribe { [weak self] response in
                print("CoreData!")
                self?.saveToCoreData(array: response)
            } onFailure: { error in
                print(error)
            }.dispose()
            return pokemons
        } else {
            return Single<[Pokemon]>.create { single in
                let pokemons = self.fetchFromCoreData()
                single(.success(pokemons))
                print("Pokemons from Core Data")
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
            print("Cached!")
            handler(image)
        } else {
            DispatchQueue.global(qos: .background).async {
                if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                    print("Downloaded!")
                    self.cache.addToCacheFolder(image: image, url: url)
                    handler(image)
                } else { handler(nil) }
            }
        }
    }
}
