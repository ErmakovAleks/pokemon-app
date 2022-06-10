//
//  CacheManager.swift
//  Pokemon-app
//
//  Created by Александр Ермаков on 09.06.2022.
//

import Foundation
import RxSwift

class CacheManager<T> {
    
    var cache = NSCache<NSString, ClassWrapper<T>>()
    
    static func intoObject<T>(notObject: T) -> ClassWrapper<T> {
        return ClassWrapper(notObject)
    }
}
