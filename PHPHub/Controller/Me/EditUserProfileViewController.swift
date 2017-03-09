//
//  EditUserProfileViewController.swift
//  PHPHub
//
//  Created by 2014-104 on 16/2/4.
//  Copyright © 2016年 ninerec. All rights reserved.
//

import UIKit

class EditUserProfileViewController: UITableViewController {
    
    @IBOutlet weak var realNameTextFiled: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var twitterTextField: UITextField!
    @IBOutlet weak var githubTextField: UITextField!
    @IBOutlet weak var blogTextField: UITextField!
    @IBOutlet weak var userIntroTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.loadCurrentUserInfo();
    }
    
    @IBAction func updateUserInfo(_ sender: UIBarButtonItem) {
        updateCurrentUserInfo()
        navigationController?.popViewController(animated: true)
    }
    
    fileprivate func loadCurrentUserInfo() {
        if let user = CurrentUserHandler.defaultHandler.user {
            realNameTextFiled.text = user.realName
            cityTextField.text = user.city
            twitterTextField.text = user.twitterAccount
            githubTextField.text = user.githubName
            blogTextField.text = user.blogURL
            userIntroTextView.text = user.signature
        }
    }
    
    fileprivate func updateCurrentUserInfo() {
        let parameters = [
            "real_name": realNameTextFiled.text!,
            "city": cityTextField.text!,
            "twitter_account": twitterTextField.text!,
            "github_url": githubTextField.text!,
            "personal_website": blogTextField.text!,
            "signature": userIntroTextView.text!
        ]
        
        self.pleaseWait()
        CurrentUserHandler.defaultHandler.updateUserInfo(parameters) { user in
            self.clearAllNotice()
            self.loadCurrentUserInfo()
        }
    }
}
