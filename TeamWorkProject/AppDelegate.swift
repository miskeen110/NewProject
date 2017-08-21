//
//  AppDelegate.swift
//  TeamWorkProject
//
//  Created by Miskeen Jatoi on 8/19/17.
//  Copyright © 2017 myorg. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        /*Setting up navigation bar color and text for Project View*/
        let navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.titleTextAttributes = ([NSForegroundColorAttributeName: UIColor.navigationBarTintColor()])
        UINavigationBar.appearance().barTintColor = UIColor.navigationBarBackgroundColor()
        navigationBarAppearace.isTranslucent = false
        UIApplication.shared.statusBarStyle = .lightContent
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = .black
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = .lightGray
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).textColor = .lightGray
        
        return true
    }
    
}
