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
        //let innerProvider = NoriSessionPokemonRequester<UrlSessionService>()
        let innerProvider = URLSessionPokemonsRequester()
        let cache = CacheProvider()
        let storageManager = CoreDataPersistencePokemonProvider()
        let provider = DataManager(innerProvider: innerProvider, cache: cache, storage: storageManager)
        let coordinator = MainCoordinator(provider: provider)
        window.rootViewController = coordinator
        window.makeKeyAndVisible()
        self.window = window
        
        return true
    }
}

