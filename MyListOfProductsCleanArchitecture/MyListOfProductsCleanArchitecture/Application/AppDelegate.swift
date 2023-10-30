//
//  AppDelegate.swift
//  MyListOfProductsCleanArchitecture
//
//  Created by Nikos Aggelidis on 29/10/23.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    @Injected(\.mainNavigationController)
    var mainNavigationController: UINavigationController
    @Injected(\.mainCoordinator)
    var mainCoordinator: MainCoordinator
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        mainCoordinator.start()
        
        window = BaseWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = mainNavigationController
        window?.makeKeyAndVisible()
        
        return true
    }
}
