//
//  CacheManager.swift
//  Pokemon-app
//
//  Created by Александр Ермаков on 09.06.2022.
//

import Foundation
import RxSwift

class CacheManager: PokemonsCacheble {
    
    // MARK: -
    // MARK: Variables
    
    private var fileManager = FileManager.default
    private var cachedImagesFolderURL: URL?
    
    // MARK: -
    // MARK: Initializators
    
    init() {
        checkAndCreateDirectory()
    }
    
    // MARK: -
    // MARK: Private functions
    
    private func pathForCacheDirectory() -> URL? {
        self.fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first
    }
    
    private func checkAndCreateDirectory() {
        self.fileManager = FileManager.default
        self.cachedImagesFolderURL = self.fileManager
            .urls(for: .cachesDirectory, in: .userDomainMask)
            .first?.appendingPathComponent("cachedImages")
        
        do {
            if let url = self.cachedImagesFolderURL {
                try? self.fileManager.createDirectory(at: url, withIntermediateDirectories: true, attributes: [:])
            }
        }
    }
    
    // MARK: -
    // MARK: Pokemons Cacheble Functions
    
    func addToCacheFolder(image: UIImage, url: URL) {
        if let percentURL = url.absoluteString
            .addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
           let pngImage = image.pngData(),
           let fileURL = self.cachedImagesFolderURL?
            .appendingPathComponent(percentURL)
        {
            do {
                try pngImage.write(to: fileURL)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func checkCache(url: URL) -> UIImage? {
        if let dataURL = self.cachedImagesFolderURL?
            .appendingPathComponent(url.absoluteString
                                        .addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!),
           let imageData = try? Data(contentsOf: dataURL)
        {
            let image = UIImage(data: imageData)
            return image
        } else {
            print("Nothing found")
            return nil
        }
    }
}
