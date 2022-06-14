//
//  CacheManager.swift
//  Pokemon-app
//
//  Created by Александр Ермаков on 09.06.2022.
//

import Foundation
import RxSwift

class CacheManager: PokemonsCacheble {
    
    var defaults = UserDefaults.standard
    
    func addToDefaults(image: UIImage, url: URL) {
        if let pngImage = image.pngData() {
            self.defaults.set(pngImage, forKey: url.absoluteString)
        }
    }
    
    func checkDefaults(url: URL) -> UIImage? {
        if let imageData = defaults.object(forKey: url.absoluteString) as? Data,
           let image = UIImage(data: imageData) {
            return image
        } else { return nil }
    }
}
