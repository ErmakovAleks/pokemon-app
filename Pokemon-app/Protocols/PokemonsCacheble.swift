//
//  PokemonsCacheble.swift
//  Pokemon-app
//
//  Created by Александр Ермаков on 10.06.2022.
//

import Foundation
import RxSwift

protocol PokemonsCacheble: AnyObject {
    
    var pokemonsCache: NSCache<NSString, ClassWrapper<Single<[Pokemon]>>> { get set }
    var detailsCache: NSCache<NSString, ClassWrapper<Single<Detail>>> { get set }
    
    func addToCache<T>(notObject: T, url: URL)
}
