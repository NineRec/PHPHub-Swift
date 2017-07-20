//
//  UserProfileViewController.swift
//  PHPHub
//
//  Created by 2014-104 on 16/2/3.
//  Copyright © 2016年 ninerec. All rights reserved.
//

import UIKit
import SafariServices

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
    
    @IBOutlet weak var topicCountLabel: UILabel!
    @IBOutlet weak var repliesCountLablel: UILabel!
    
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let user = self.user {
            self.avatarImageView.kf.setImage(
                with: URL(string: user.avatar)!,
                placeholder: UIImage(named: "avatar_placeholder"))
            self.usernameLabel.text = user.username
            self.realnameLabel.text = user.realName
            self.userIntroLabel.text = user.signature
            self.localLabel.text = user.city
            self.githubLabel.text = user.githubName
            self.twitterLabel.text = user.twitterAccount
            self.blogLabel.text = user.blogURL
            self.createAtLabel.text = user.createdAtDate
            
            self.topicCountLabel.text = String(user.topicCount)
            self.repliesCountLablel.text = String(user.replyCount)
            
            if let currentUser = CurrentUserHandler.defaultHandler.user {
                if currentUser.userId == user.userId {
                    let editProfileImage = UIImage(named: "edit_profile_icon")
                    let rightBarButtonItem = UIBarButtonItem(image: editProfileImage, style: .plain, target: self, action: Selector("showEditUserProfile"))
                    navigationController?.navigationItem.rightBarButtonItem = rightBarButtonItem
                }
            }
        }
        
        setupCornerView(self.avatarImageView)
    }
    
    // MARK: - Delegate TableView
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let user = self.user {
            let section = (indexPath as NSIndexPath).section
            
            switch section {
            case 3 where !user.githubURL.isEmpty :
                jumpToWebView(user.githubURL)
            case 4 where !user.twitterAccount.isEmpty:
                jumpToWebView(AppConfig.TwitterUrl + user.twitterAccount)
            case 5 where !user.blogURL.isEmpty :
                jumpToWebView(user.blogURL)
            default:
                return
            }
        }
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier, let user = self.user {
            switch identifier {
            case "ShowAttention":
                let attentionVC = segue.destination as! TopicListTableViewController
                attentionVC.topicListApi = .attention(user.userId)
                attentionVC.hidesBottomBarWhenPushed = true
                
                if let currentUser = CurrentUserHandler.defaultHandler.user , currentUser.userId == user.userId {
                    attentionVC.title = "我的关注"
                } else {
                    attentionVC.title = "TA的关注"
                }
            case "ShowFavorite":
                let favoriteVC = segue.destination as! TopicListTableViewController
                favoriteVC.topicListApi = .favorite(user.userId)
                favoriteVC.hidesBottomBarWhenPushed = true
                
                if let currentUser = CurrentUserHandler.defaultHandler.user , currentUser.userId == user.userId {
                    favoriteVC.title = "我的收藏"
                } else {
                    favoriteVC.title = "TA的收藏"
                }
            case "ShowUser":
                let userPublicedVC = segue.destination as! TopicListTableViewController
                userPublicedVC.topicListApi = .user(user.userId)
                userPublicedVC.hidesBottomBarWhenPushed = true
                    
                if let currentUser = CurrentUserHandler.defaultHandler.user , currentUser.userId == user.userId {
                    userPublicedVC.title = "我的帖子"
                } else {
                    userPublicedVC.title = "TA的帖子"
                }
            default:
                break
            }
        }

    }
    
    func jumpToWebView(_ urlString: String) {
        let safariViewController = SFSafariViewController(url: URL(string: urlString)!)
        self.present(safariViewController, animated: true, completion: nil)
    }
    
    fileprivate func setupCornerView(_ view: UIView) {
        view.layer.cornerRadius = view.frame.height / 2
        view.layer.masksToBounds = true
    }
}
