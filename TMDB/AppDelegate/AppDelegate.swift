//
//  AppDelegate.swift
//  Sample MVP
//
//  Created by Bassem Abbas on 9/18/19.
//  Copyright © 2019 Ibtikar Technologies, Co. Ltd. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupNetworking()
        window = UIWindow(frame: UIScreen.main.bounds)
        let view = ListActorsModule.createListActorsModule()
        let navigation = UINavigationController(rootViewController: view)
        navigation.navigationBar.barTintColor = UIColor.init(red: 74, green: 188, blue: 249, alpha: 1)
        window!.rootViewController = navigation
        window!.makeKeyAndVisible()
        return true
	}


}

