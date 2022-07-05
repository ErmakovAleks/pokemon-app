//
//  CoreDataManager.swift
//  Pokemon-app
//
//  Created by Александр Ермаков on 04.07.2022.
//

import Foundation
import CoreData

public class StorageManager: PokemonsStorageProvider {
    
    // MARK: -
    // MARK: Variables
    
    private lazy var context = persistentContainer.viewContext
    private let fetchRequest = PokemonEntity.fetchRequest()
    private let limit = 20
    
    // MARK: -
    // MARK: Private functions
    
    private func configurePokemon(pokemonEntity: PokemonEntity) -> Pokemon? {
        if
            let name = pokemonEntity.name,
            let stringUrl = pokemonEntity.url,
            let url = URL(string: stringUrl)
        {
            return Pokemon(name: name, url: url)
        } else {
            return nil
        }
    }
    
    // MARK: -
    // MARK: PokemonsCoreDataProvider
    
    func saveToCoreData(array: [Pokemon]) {
        array.forEach { pokemon in
            let entity = PokemonEntity(context: context)
            entity.name = pokemon.name
            entity.url = pokemon.url.absoluteString
            
            do {
                try context.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
    }
    
    func fetchAllFromCoreData() -> [Pokemon] {
        var pokemons: [Pokemon] = []
        
        do {
            let savedPokemons = try context.fetch(fetchRequest)
            savedPokemons.forEach { pokemon in
                self.configurePokemon(pokemonEntity: pokemon).map { pokemons.append($0) }
            }
          } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
          }
        return pokemons
    }
    
    func fetchFromCoreData(offset: Int) -> [Pokemon] {
        var pokemons: [Pokemon] = []

        do {
            let savedPokemons = try context.fetch(fetchRequest)
            if savedPokemons.count >= offset + self.limit {
                savedPokemons[offset...(offset + self.limit)].forEach { pokemon in
                    self.configurePokemon(pokemonEntity: pokemon).map { pokemons.append($0) }
                }
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
          }
        return pokemons
    }
    
    func count() -> Int? {
        try? self.context.count(for: self.fetchRequest)
    }
    
    // MARK: -
    // MARK: Core Data
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PokemonDataModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                print("Data is saved!")
            } catch {
                let error = error as NSError
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
}
