//
//  MainTabBarController.swift
//  PHPHub
//
//  Created by 2014-104 on 15/12/10.
//  Copyright © 2015年 ninerec. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.setupTabBarItems()
        self.delegate = self
    }
    
    private func setupTabBarItems() {
        let essentialNC = self.viewControllers![0] as! UINavigationController
        let essentialVC = essentialNC.topViewController! as! TopicListTableViewController
        essentialVC.title = "精华"
        essentialVC.filter = .Essential
        
        let wikiNC = self.viewControllers![2] as! UINavigationController
        let wikiVC = wikiNC.topViewController! as! TopicListTableViewController
        wikiVC.title = "社区WIKI"
        wikiVC.filter = .Wiki
    }
}

extension MainTabBarController: UITabBarControllerDelegate {
    func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
        guard !CurrentUserHandler.defaultHandler.isLoggedIn else {
            return true
        }
        
        let visibleController: UIViewController
        
        if let navigationController = viewController as? UINavigationController {
            visibleController = navigationController.topViewController ?? viewController
        } else {
            visibleController = viewController
        }
        
        let shouldPresentSignInScreen = AppConfig.viewControllerClassesThatRequireLogin.contains { $0 == visibleController.dynamicType }
        
        if shouldPresentSignInScreen {
            LoginViewController.presentLoginViewController() { success in
                if success {
                    CurrentUserHandler.defaultHandler.refreshUserInfo()
                    self.selectedViewController = viewController
                }
            }
            
            return false
        }
        
        return true
    }
}
