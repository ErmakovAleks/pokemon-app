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
    let requester = URLSessionPokemonsRequester()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        var navigationController = UINavigationController()
        let coordinator = MainCoordinator(navigationController: navigationController)
        navigationController.pushViewController(coordinator, animated: true)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
        
        return true
    }
}

