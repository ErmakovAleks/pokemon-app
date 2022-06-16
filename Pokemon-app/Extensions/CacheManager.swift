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
        checkAndCreateDirectory(folder: "cachedImages")
    }
    
    // MARK: -
    // MARK: Private functions
    
    private func pathForCacheDirectory() -> URL? {
        self.fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first
    }
    
    private func checkAndCreateDirectory(folder: String) {
        self.fileManager = FileManager.default
        self.cachedImagesFolderURL = self.fileManager
            .urls(for: .cachesDirectory, in: .userDomainMask)
            .first?.appendingPathComponent(folder)
        
        do {
            if let url = self.cachedImagesFolderURL {
                try? self.fileManager.createDirectory(at: url, withIntermediateDirectories: true, attributes: [:])
            }
        }
    }
    
    // ИСПРАВИТЬ ЭТОТ ГОВНОКОД!
    
    private func pathAndFileName(url: URL) -> [String] {
        var pathAndFileName = [String]()
        var path = url.path
        var name = url.path
        if let i = path.lastIndex(of: "/") {
            path.removeSubrange(i...)
            path.remove(at: path.startIndex)
            name.removeSubrange(name.startIndex...i)
            pathAndFileName.append(path)
            pathAndFileName.append(name)
        }
        return pathAndFileName
    }
    
    private func addSubFolders(path: String) {
        let url = self.cachedImagesFolderURL?.appendingPathComponent(path)
        
        do {
            if let url = url {
                try? self.fileManager.createDirectory(at: url, withIntermediateDirectories: true, attributes: [:])
            }
        }
    }
    
    // MARK: -
    // MARK: Pokemons Cacheble Functions
    
    func addToCacheFolder(image: UIImage, url: URL) {
        let pathAndName = self.pathAndFileName(url: url)
        self.addSubFolders(path: pathAndName[0])
        if let pngImage = image.pngData(),
           let fileURL = self.cachedImagesFolderURL?
            .appendingPathComponent(pathAndName[0])
            .appendingPathComponent(pathAndName[1])
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
            .appendingPathComponent(self.pathAndFileName(url: url)[0])
            .appendingPathComponent(self.pathAndFileName(url: url)[1]),
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
