//
//  AppDelegate.swift
//  Login_App
//
//  Created by Henadzi on 17/11/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        if let loginData = UserDefaults.standard.object(forKey: userLogindataUDKey) as? [String],
           !loginData[1].isEmpty {
            let storyboard = UIStoryboard(name: "HomeViewControllerStoryboard", bundle: nil)
            let homeVC = storyboard.instantiateViewController(withIdentifier: "HomeViewController")
            window?.rootViewController = NavigationController(rootViewController: homeVC)
        } else {
            let loginStoryboard = UIStoryboard(name: "LoginViewController", bundle: nil)
            let loginVC = loginStoryboard.instantiateViewController(withIdentifier: "LoginViewController")
            window?.rootViewController = NavigationController(rootViewController: loginVC)
        }
        window?.makeKeyAndVisible()
        
        return true
    }
}

