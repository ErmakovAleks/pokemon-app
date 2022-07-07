//
//  PokemonsCoreDataProvider.swift
//  Pokemon-app
//
//  Created by Александр Ермаков on 04.07.2022.
//

import Foundation
import CoreData

protocol PokemonsPersistenceProvidable {
    
    func savePokemonsToCoreData(array: [Pokemon], handler: @escaping PokemonsCardsCompletion)
    
    func saveDetailsToCoreData(details: PokemonDetails, url: URL, handler: @escaping PokemonDetailCompletion)
    
    func fetchPokemons(offset: Int, limit: Int) -> PokemonsResult
    
    func fetchDetails(for url: URL) -> DetailsResult
    
    func containsPokemon(for url: URL) -> Bool
    
    func count() -> Int?
}
