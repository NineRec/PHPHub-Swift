//
//  LoginViewController.swift
//  PHPHub
//
//  Created by 2014-104 on 15/12/23.
//  Copyright © 2015年 ninerec. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    static let storyboardIdentifier = "login"
    
    fileprivate var completion: ((_ success: Bool) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        navigationItem.title = "请登录"
    }
    
    @IBAction func scanLogin() {
        let scannerVC = QRCodeViewController()
        scannerVC.completion = self.completion
        navigationController?.pushViewController(scannerVC, animated: true)
    }
    
    @IBAction func introduceLogin() {
        let loginGuideVC = LoginGuideViewController()
        loginGuideVC.guideUrl = AppConfig.LoginGuide
        loginGuideVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(loginGuideVC, animated: false)
    }
    
    @IBAction func closeLoginViewController() {
        appDelegate.tabBarController.dismiss(animated: true) { }
    }
    
    static func presentLoginViewController(withCompletion completion: @escaping ((Bool) -> Void)) {
        let loginNC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginNC") as! UINavigationController
        let loginVC = loginNC.topViewController! as! LoginViewController
        loginVC.completion = completion
        
        // Customize the login view controller presentation and transition styles.
        loginNC.modalPresentationStyle = .overCurrentContext
        loginNC.modalTransitionStyle = .crossDissolve
        
        // Present the login view controller.
        appDelegate.tabBarController.present(loginNC, animated: true, completion: nil)
    }
}
