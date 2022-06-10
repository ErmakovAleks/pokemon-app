//
//  ClassWrapper.swift
//  Pokemon-app
//
//  Created by Александр Ермаков on 09.06.2022.
//

import Foundation

class ClassWrapper<T> {
    
    let value: T
    
    init(_ value: T) {
        self.value = value
    }
}
