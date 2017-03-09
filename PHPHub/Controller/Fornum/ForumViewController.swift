//
//  ForumViewController.swift
//  PHPHub
//
//  Created by 2014-104 on 15/12/9.
//  Copyright © 2015年 ninerec. All rights reserved.
//

import UIKit
import PageMenu

class ForumViewController: UIViewController {

    var pageMenu: CAPSPageMenu?
    var controllerArray: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // hide the navigationBar first
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        // Customize menu (Optional)
        let parameters: [CAPSPageMenuOption] = [
            .scrollMenuBackgroundColor(UIColor.white),
            .viewBackgroundColor(UIColor(red: 240/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 1.0)),
            .selectionIndicatorColor(UIColor(red: 18.0/255.0, green: 150.0/255.0, blue: 225.0/255.0, alpha: 1.0)),
            .bottomMenuHairlineColor(UIColor(red: 20.0/255.0, green: 20.0/255.0, blue: 20.0/255.0, alpha: 0.1)),
            .selectedMenuItemLabelColor(UIColor(red: 18.0/255.0, green: 150.0/255.0, blue: 225.0/255.0, alpha: 1.0)),
            .unselectedMenuItemLabelColor(UIColor(red: 40.0/255.0, green: 40.0/255.0, blue: 40.0/255.0, alpha: 1.0)),
            .menuItemFont(UIFont(name: "HelveticaNeue", size: 13.0)!),
            .menuHeight(44.0),
            .menuItemWidth(90.0),
            .centerMenuItems(true)
        ]
        
        let newestVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TopicList") as! TopicListTableViewController
        newestVC.title = "最新"
        newestVC.topicListApi = .newest
        let hotestVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TopicList") as! TopicListTableViewController
        hotestVC.title = "热门"
        hotestVC.topicListApi = .hotest
        let jobVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TopicList") as! TopicListTableViewController
        jobVC.title = "招聘"
        jobVC.topicListApi = .jobs
        
        
        controllerArray = [newestVC, hotestVC, jobVC]
        
        // Configure the scroll menu
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x: 0.0, y: 20.0, width: self.view.frame.width, height: self.view.frame.height - 20.0), pageMenuOptions: parameters)
        pageMenu!.delegate = self
        
        self.addChildViewController(pageMenu!)
        self.view.addSubview(pageMenu!.view)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // hide navigation bar
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
        
        super.viewWillDisappear(animated)
    }
}

extension ForumViewController: CAPSPageMenuDelegate {
    func willMoveToPage(_ controller: UIViewController, index: Int) {
        return
    }
    
    func didMoveToPage(_ controller: UIViewController, index: Int) {
        return
    }
}
