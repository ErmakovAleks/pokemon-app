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
    var coordinator: MainCoordinator?
    let requester = URLSessionPokemonsRequester()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
//        let pokemonsListController = PokemonsListController(provider: requester)
//        let navigationController = UINavigationController(rootViewController: pokemonsListController)
        let navigationController = UINavigationController()
        self.coordinator = MainCoordinator(navigationController: navigationController)
        self.coordinator?.start()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
        
        return true
    }
}

