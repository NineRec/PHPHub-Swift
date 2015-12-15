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
    
        setupTabBarItems()
        
        self.delegate = self
    }
    
    private func setupTabBarItems() {
        let essentialVC = UIStoryboard(name: "Topic", bundle: nil).instantiateViewControllerWithIdentifier("TopicList")
        essentialVC.title = "推荐"
        let essentialNC = UINavigationController(rootViewController: essentialVC)
        essentialNC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "essential_icon"), selectedImage: UIImage(named: "essential_selected_icon"))
        
        let forumVC = ForumViewController()
        forumVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "forum_icon"), selectedImage: UIImage(named: "forum_selected_icon"))
        
        let wikiVC = UIViewController()
        wikiVC.title = "社区WIKI"
        let wikiNC = UINavigationController(rootViewController: wikiVC)
        wikiNC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "wiki_icon"), selectedImage: UIImage(named: "wiki_selected_icon"))
        
        let meVC = UIViewController()
        meVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "me_icon"), selectedImage: UIImage(named: "me_selected_icon"))
        
        let controllers: [UIViewController] = [essentialNC, forumVC, wikiNC, meVC]
        setViewControllers(controllers, animated: true)
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }
}

extension MainTabBarController: UITabBarControllerDelegate {
    
}
