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
    
    func fetchAllFromCoreData() -> [Pokemon]
    
    func fetchFromCoreData(offset: Int) -> [Pokemon]
    
    func count() -> Int?
}
