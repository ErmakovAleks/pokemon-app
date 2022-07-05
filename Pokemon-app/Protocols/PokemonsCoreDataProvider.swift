//
//  PokemonsCoreDataProvider.swift
//  Pokemon-app
//
//  Created by Александр Ермаков on 04.07.2022.
//

import Foundation
import CoreData

protocol PokemonsCoreDataProvider {
    
    func saveToCoreData(array: [Pokemon])
    
    func fetchFromCoreData() -> [Pokemon]
}
