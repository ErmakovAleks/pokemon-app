//
//  PokemonsCoreDataProvider.swift
//  Pokemon-app
//
//  Created by Александр Ермаков on 04.07.2022.
//

import Foundation
import CoreData

protocol PokemonsPersistenceProvidable {
    
    func save(array: [Pokemon], handler: @escaping PokemonsCardsCompletion)
    
    func save(details: PokemonDetails, url: URL, handler: @escaping PokemonDetailCompletion)
    
    func pokemons(offset: Int, limit: Int) -> PokemonsResult
    
    func details(for url: URL) -> DetailsResult
    
    func containsPokemon(for url: URL) -> Bool
    
    func count() -> Int?
}
