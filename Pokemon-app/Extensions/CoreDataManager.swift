//
//  CoreDataManager.swift
//  Pokemon-app
//
//  Created by Александр Ермаков on 04.07.2022.
//

import Foundation
import CoreData

public class CoreDataManager: PokemonsCoreDataProvider {
    
    // MARK: -
    // MARK: Variables
    
    private lazy var context = persistentContainer.viewContext
    
    // MARK: -
    // MARK: PokemonsCoreDataProvider
    
    func saveToCoreData(array: [Pokemon]) {
        for pokemon in array {
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
    
    func fetchFromCoreData() -> [Pokemon] {
        var pokemons: [Pokemon] = []
        let fetchRequest = PokemonEntity.fetchRequest()
        
        do {
            let savedPokemons = try context.fetch(fetchRequest)
            for pokemon in savedPokemons {
                if
                    let name = pokemon.name,
                    let stringUrl = pokemon.url,
                    let url = URL(string: stringUrl)
                {
                    pokemons.append(Pokemon(name: name, url: url))
                }
            }
          } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
          }
        return pokemons
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
