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
                    NSURL(string: user.avatar)!, placeholderImage: UIImage(named: "avatar_placeholder"))
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
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "ShowProfile":
                let userProfileVC = segue.destinationViewController as! UserProfileViewController
                userProfileVC.user = self.user
            default:
                break
            }
        }
    }
    
    private func setupCornerView(view: UIView) {
        view.layer.cornerRadius = view.frame.height / 2
        view.layer.masksToBounds = true
    }
}
