//
//  CacheManager.swift
//  Pokemon-app
//
//  Created by Александр Ермаков on 09.06.2022.
//

import Foundation
import RxSwift

class CacheManager: PokemonsCacheble {
    
    var pokemonsCache = NSCache<NSString, ClassWrapper<Single<[Pokemon]>>>()
    var detailsCache = NSCache<NSString, ClassWrapper<Single<Detail>>>()
    
    func intoObject<T>(from notObj: T) -> ClassWrapper<T> {
        return ClassWrapper<T>(notObj)
    }
    
    func addToCache<T>(notObject: T, url: URL) {
        let object = intoObject(from: notObject)
        switch object {
        case let obj as ClassWrapper<Single<[Pokemon]>>:
            self.pokemonsCache.setObject(obj, forKey: url.absoluteString as NSString)
        case let obj as ClassWrapper<Single<Detail>>:
            self.detailsCache.setObject(obj, forKey: url.absoluteString as NSString)
        default:
            break
        }
    }
}
