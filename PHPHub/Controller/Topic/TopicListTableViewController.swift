//
//  TopicListTableViewController.swift
//  PHPHub
//
//  Created by 2014-104 on 15/12/9.
//  Copyright © 2015年 ninerec. All rights reserved.
//

import UIKit
import Kingfisher

class TopicListTableViewController: UITableViewController {
    
    var topicList = [Topic]()
    var atPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.clearsSelectionOnViewWillAppear = true
        
        // pull to refresh
        refreshControl?.addTarget(self, action: "handleRefresh:", forControlEvents: UIControlEvents.ValueChanged)
        
        // temp the data
        TopicApi.getEssentialTopicList(atPage) { topicList in
            self.topicList  = topicList
        }
    }

    func handleRefresh(refreshControl: UIRefreshControl) {
        TopicApi.getEssentialTopicList(atPage) { topicList in
            self.topicList  = topicList
        }
        
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topicList.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "TopicListCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! TopicListTableViewCell
        
        let topic = topicList[indexPath.row]
        cell.topicTitleLabel.text = topic.topicTitle
        cell.topicInfoLabel.text = "\(topic.node.nodeName) • 最后由 \(topic.lastReplyUser.username) • \(topic.updateAt.timeAgoSinceNow())"
        cell.topicRepliesCountLabel.text = String(topic.topicRepliesCount)
        cell.avatarImageView.kf_setImageWithURL(NSURL(string: topic.user.avatar)!)
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
