//
//  MeTableViewController.swift
//  PHPHub
//
//  Created by 2014-104 on 15/12/23.
//  Copyright © 2015年 ninerec. All rights reserved.
//

import UIKit
import Kingfisher

class MeTableViewController: UITableViewController {

    // MARK: - Properties
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var userIntroLabel: UILabel!
    @IBOutlet weak var unreadCountLabel: UILabel!
    
    var user: User? {
        didSet {
            if let user = user {
                self.avatarImageView.kf_setImageWithURL(
                    URL(string: user.avatar)!, placeholderImage: UIImage(named: "avatar_placeholder"))
                self.usernameLabel.text = user.username
                self.userIntroLabel.text = user.signature
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCornerView(unreadCountLabel)
        setupCornerView(avatarImageView)
        
        self.user = CurrentUserHandler.defaultHandler.user
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let section = indexPath.section
//        let row = indexPath.row
//        
//        var nextVC: UIViewController
//        
//        if section == 0 && row == 0 {
//            
//        } else if section == 1 {
//            
//        } else if section == 2 {
//            
//        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "ShowUserProfile":
                let userProfileVC = segue.destination as! UserProfileViewController
                userProfileVC.user = self.user
                userProfileVC.title = "个人信息"
                userProfileVC.hidesBottomBarWhenPushed = true
            case "ShowAttention":
                let attentionVC = segue.destination as! TopicListTableViewController
                if let user = CurrentUserHandler.defaultHandler.user {
                    attentionVC.topicListApi = .attention(user.userId)
                    attentionVC.title = "我的关注"
                    attentionVC.hidesBottomBarWhenPushed = true
                }
            case "ShowFavorite":
                let favoriteVC = segue.destination as! TopicListTableViewController
                if let user = CurrentUserHandler.defaultHandler.user {
                    favoriteVC.topicListApi = .favorite(user.userId)
                    favoriteVC.title = "我的收藏"
                    favoriteVC.hidesBottomBarWhenPushed = true
                }
            case "ShowUser":
                let userPublicedVC = segue.destination as! TopicListTableViewController
                if let user = CurrentUserHandler.defaultHandler.user {
                    userPublicedVC.topicListApi = .user(user.userId)
                    userPublicedVC.title = "我的帖子"
                    userPublicedVC.hidesBottomBarWhenPushed = true
                }
            default:
                break
            }
        }
    }
    
    fileprivate func setupCornerView(_ view: UIView) {
        view.layer.cornerRadius = view.frame.height / 2
        view.layer.masksToBounds = true
    }
}
