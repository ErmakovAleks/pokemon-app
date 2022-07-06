//
//  PokemonsCoreDataProvider.swift
//  Pokemon-app
//
//  Created by Александр Ермаков on 04.07.2022.
//

import Foundation
import CoreData

protocol PokemonsStorageProvider {
    
    func saveToCoreData(array: [Pokemon])
    
    func fetchFromCoreData(offset: Int, limit: Int) -> [Pokemon]
    
    func count() -> Int?
}
