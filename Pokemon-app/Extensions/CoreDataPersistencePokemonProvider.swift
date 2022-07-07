//
//  CoreDataManager.swift
//  Pokemon-app
//
//  Created by Александр Ермаков on 04.07.2022.
//

import Foundation
import CoreData

public class CoreDataPersistencePokemonProvider: PokemonsPersistenceProvidable {
    
    // MARK: -
    // MARK: Variables
    
    private lazy var context = persistentContainer.viewContext
    private let fetchPokemonsRequest = PokemonEntity.fetchRequest()
    private let fetchDetailsRequest = PokemonDetailsEntity.fetchRequest()
    private let fetchSpritesRequest = SpritesEntity.fetchRequest()
    
    // MARK: -
    // MARK: Private functions
    
    private func configurePokemons(pokemonEntities: [PokemonEntity]) -> [Pokemon] {
        var pokemons: [Pokemon] = []
        pokemonEntities.forEach { entity in
            if
                let name = entity.name,
                let stringURL = entity.url,
                let url = URL(string: stringURL)
            {
                pokemons.append(Pokemon(name: name, url: url))
            }
        }
        return pokemons
    }
    
    // MARK: -
    // MARK: PokemonsPersistenceProvidable
    
    func savePokemonsToCoreData(array: [Pokemon], handler: @escaping PokemonsCardsCompletion) {
        array.forEach { pokemon in
            let entity = PokemonEntity(context: context)
            entity.name = pokemon.name
            entity.url = pokemon.url.absoluteString
        }
        if let _ = try? context.save() {
            handler(.success(array))
        } else {
            handler(.failure(Errors.recordingIsFailed))
        }
    }
    
    func saveDetailsToCoreData(details: PokemonDetails, url: URL, handler: @escaping PokemonDetailCompletion) {
        let entity = PokemonDetailsEntity(context: context)
        entity.name = details.name
        entity.url = url
        entity.sprites?.frontDefault = details.sprites?.frontDefault
        entity.sprites?.frontShiny = details.sprites?.frontShiny
        entity.sprites?.backDefault = details.sprites?.backDefault
        entity.sprites?.backShiny = details.sprites?.backShiny
        if let height = details.height, let weight = details.weight {
            entity.height = Int16(height)
            entity.weight = Int16(weight)
        }
        if let _ = try? context.save() {
            handler(.success(details))
        } else {
            handler(.failure(Errors.recordingIsFailed))
        }
    }
    
    func fetchPokemons(offset: Int, limit: Int = 20) -> PokemonsResult {
        self.fetchPokemonsRequest.fetchOffset = offset
        self.fetchPokemonsRequest.fetchLimit = limit
        
        if
            let savedPokemons = try? self.context.fetch(self.fetchPokemonsRequest),
            self.configurePokemons(pokemonEntities: savedPokemons).count != 0
        {
            return PokemonsResult.success(self.configurePokemons(pokemonEntities: savedPokemons))
        } else {
            return PokemonsResult.failure(Errors.fetchingIsFailed)
        }
    }
    
    func fetchDetails(for url: URL) -> DetailsResult {
        <#code#>
    }
    
    func count() -> Int? {
        return try? self.context.count(for: self.fetchPokemonsRequest)
    }
    
    func containsPokemon(for url: URL) -> Bool {
        self.fetchDetailsRequest.predicate = NSPredicate(format: "url == %@", url.absoluteString)
        let objects = try? self.context.fetch(self.fetchDetailsRequest)
        if let objects = objects {
            return !objects.isEmpty
        } else {
            return false
        }
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
        let context = self.persistentContainer.viewContext
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
