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
            .ScrollMenuBackgroundColor(UIColor.whiteColor()),
            .ViewBackgroundColor(UIColor(red: 240/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 1.0)),
            .SelectionIndicatorColor(UIColor(red: 18.0/255.0, green: 150.0/255.0, blue: 225.0/255.0, alpha: 1.0)),
            .BottomMenuHairlineColor(UIColor(red: 20.0/255.0, green: 20.0/255.0, blue: 20.0/255.0, alpha: 0.1)),
            .SelectedMenuItemLabelColor(UIColor(red: 18.0/255.0, green: 150.0/255.0, blue: 225.0/255.0, alpha: 1.0)),
            .UnselectedMenuItemLabelColor(UIColor(red: 40.0/255.0, green: 40.0/255.0, blue: 40.0/255.0, alpha: 1.0)),
            .MenuItemFont(UIFont(name: "HelveticaNeue", size: 13.0)!),
            .MenuHeight(44.0),
            .MenuItemWidth(90.0),
            .CenterMenuItems(true)
        ]
        
        let newestVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("TopicList") as! TopicListTableViewController
        newestVC.title = "最新"
        newestVC.filter = .Newest
        let hotestVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("TopicList") as! TopicListTableViewController
        hotestVC.title = "热门"
        hotestVC.filter = .Hotest
        let jobVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("TopicList") as! TopicListTableViewController
        jobVC.title = "招聘"
        jobVC.filter = .Jobs
        
        
        controllerArray = [newestVC, hotestVC, jobVC]
        
        // Configure the scroll menu
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRectMake(0.0, 20.0, self.view.frame.width, self.view.frame.height - 20.0), pageMenuOptions: parameters)
        pageMenu!.delegate = self
        
        self.addChildViewController(pageMenu!)
        self.view.addSubview(pageMenu!.view)
    }
    
    override func viewWillAppear(animated: Bool) {
        // hide navigation bar
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
        
        super.viewWillDisappear(animated)
    }
}

extension ForumViewController: CAPSPageMenuDelegate {
    func willMoveToPage(controller: UIViewController, index: Int) {
        return
    }
    
    func didMoveToPage(controller: UIViewController, index: Int) {
        return
    }
}
