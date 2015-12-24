//
//  LoginViewController.swift
//  PHPHub
//
//  Created by 2014-104 on 15/12/23.
//  Copyright © 2015年 ninerec. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "请登录"
    }
    
    @IBAction func scanLogin() {
        let scannerVC = QRCodeViewController()
        navigationController?.pushViewController(scannerVC, animated: true)
    }
    
    @IBAction func introduceLogin() {
        let loginGuideVC = LoginGuideViewController()
        loginGuideVC.guideUrl = AppConfig.LoginGuide
        loginGuideVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(loginGuideVC, animated: false)
    }
}
