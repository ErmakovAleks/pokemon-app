//
//  AppDelegate.swift
//  Pokemon-app
//
//  Created by Александр Ермаков on 04.02.2022.
//

import UIKit
import AVKit
import AVFoundation
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let innerProvider = NoriSessionPokemonRequester<UrlSessionService>()
        let cache = CacheManager()
        let provider = DataProvider(innerProvider: innerProvider, cache: cache)
        let coordinator = MainCoordinator(provider: provider)
        window.rootViewController = coordinator
        window.makeKeyAndVisible()
        self.window = window
        
        return true
    }
    
    // MARK: -
    // MARK: Core Data
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PokemonDataModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                print("Data is saved!")
            } catch {
                let error = error as NSError
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
}

