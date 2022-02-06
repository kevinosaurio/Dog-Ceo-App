//
//  AppDelegate.swift
//  Dog Ceo App
//
//  Created by Kevin Bolivar on 05-02-22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window:UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = getMainViewController()
        window?.makeKeyAndVisible()
        return true
    }
    
    func getMainViewController() -> UIViewController {
        let navigationController = UINavigationController(rootViewController: DogBreedRouter.getDogBreedViewController())
        return navigationController
    }
}

