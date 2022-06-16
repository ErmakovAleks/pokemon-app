//
//  PokemonsCacheble.swift
//  Pokemon-app
//
//  Created by Александр Ермаков on 10.06.2022.
//

import Foundation
import RxSwift

protocol PokemonsCacheble {
    
    func addToCacheFolder(image: UIImage, url: URL)
    
    func checkCache(url: URL) -> UIImage?
}
