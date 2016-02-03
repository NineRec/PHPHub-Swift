//
//  AppDelegate.swift
//  PHPHub
//
//  Created by 2014-104 on 15/12/7.
//  Copyright © 2015年 ninerec. All rights reserved.
//

import UIKit

let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var tabBarController: UITabBarController {
        return self.window!.rootViewController as! UITabBarController
    }

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        CurrentUserHandler.setDefaultHandler(CurrentUserHandler())
        return true
    }
}
