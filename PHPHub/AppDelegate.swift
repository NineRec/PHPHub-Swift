//
//  AppDelegate.swift
//  PHPHub
//
//  Created by 2014-104 on 15/12/7.
//  Copyright © 2015年 ninerec. All rights reserved.
//

import UIKit

let appDelegate = UIApplication.shared.delegate as! AppDelegate

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var tabBarController: UITabBarController {
        return self.window!.rootViewController as! UITabBarController
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        CurrentUserHandler.setDefaultHandler(CurrentUserHandler())
        return true
    }
}
