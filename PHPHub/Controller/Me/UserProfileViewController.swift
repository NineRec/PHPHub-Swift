//
//  UserProfileViewController.swift
//  PHPHub
//
//  Created by 2014-104 on 16/2/3.
//  Copyright © 2016年 ninerec. All rights reserved.
//

import UIKit

class UserProfileViewController: UITableViewController {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var realnameLabel: UILabel!
    @IBOutlet weak var userIntroLabel: UILabel!
    @IBOutlet weak var localLabel: UILabel!
    @IBOutlet weak var githubLabel: UILabel!
    @IBOutlet weak var twitterLabel: UILabel!
    @IBOutlet weak var blogLabel: UILabel!
    @IBOutlet weak var createAtLabel: UILabel!
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let user = self.user {
            self.avatarImageView.kf_setImageWithURL(
                NSURL(string: user.avatar)!, placeholderImage: UIImage(named: "avatar_placeholder"))
            self.usernameLabel.text = user.username
            self.realnameLabel.text = user.realName
            self.userIntroLabel.text = user.signature
            self.localLabel.text = user.city
            self.githubLabel.text = user.githubName
            self.twitterLabel.text = user.twitterAccount
            self.blogLabel.text = user.blogURL
            self.createAtLabel.text = user.createdAtDate
        }
        
        setupCornerView(self.avatarImageView)
    }

    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    private func setupCornerView(view: UIView) {
        view.layer.cornerRadius = view.frame.height / 2
        view.layer.masksToBounds = true
    }
}
