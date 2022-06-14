//
//  PokemonsCacheble.swift
//  Pokemon-app
//
//  Created by Александр Ермаков on 10.06.2022.
//

import Foundation
import RxSwift

protocol PokemonsCacheble {
    
    var defaults: UserDefaults { get set }
    
    func addToDefaults(image: UIImage, url: URL)
    
    func checkDefaults(url: URL) -> UIImage?
}
