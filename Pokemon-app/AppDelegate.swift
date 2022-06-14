//
//  AppDelegate.swift
//  Pokemon-app
//
//  Created by Александр Ермаков on 04.02.2022.
//

import UIKit
import AVKit
import AVFoundation

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let innerProvider = NoriSessionPokemonRequester<UrlSessionService>()
        let cache = CacheManager()
        let provider = DataProvider(innerProvider: innerProvider, cache: cache)
        //let provider = URLSessionPokemonsRequester()
        let coordinator = MainCoordinator(provider: provider)
        window.rootViewController = coordinator
        window.makeKeyAndVisible()
        self.window = window
        
        return true
    }
}

