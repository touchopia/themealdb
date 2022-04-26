//
//  AppDelegate.swift
//  themealdb
//
//  Created by Phil Wright on 4/25/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // Navigation Setup
        UINavigationBar.appearance().tintColor = UIColor.black
        UINavigationBar.appearance().barStyle = .default
        UINavigationBar.appearance().prefersLargeTitles = true
        
        return true
    }
}

