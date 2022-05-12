//
//  RootViewGettableExtension.swift
//  Pokemon-app
//
//  Created by Александр Ермаков on 08.03.2022.
//

import Foundation

extension RootViewGettable {
    
    var rootView: RootView? {
        self.view as? RootView
    }
}
