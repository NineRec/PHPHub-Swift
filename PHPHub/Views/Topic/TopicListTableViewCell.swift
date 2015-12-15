//
//  TopicListTableViewCell.swift
//  PHPHub
//
//  Created by 2014-104 on 15/12/9.
//  Copyright © 2015年 ninerec. All rights reserved.
//

import UIKit

class TopicListTableViewCell: UITableViewCell {

    @IBOutlet weak var basicView: UIView!
    @IBOutlet weak var topicTitleLabel: UILabel!
    @IBOutlet weak var topicInfoLabel: UILabel!
    @IBOutlet weak var topicRepliesCountLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}