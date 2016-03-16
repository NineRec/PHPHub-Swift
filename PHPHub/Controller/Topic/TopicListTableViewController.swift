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
    var topicList = [Topic]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    var atPage = 1
    var topicListApi: TopicListApi? = nil {
        didSet {
            if let topicListApi = self.topicListApi {
                self.atPage = 1
                topicListApi.getTopicListAtPage(self.atPage) { topicList in
                    self.topicList  = topicList
                    self.atPage += 1
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.clearsSelectionOnViewWillAppear = true
        
        // pull to refresh
        refreshControl?.addTarget(self, action: "handleRefresh:", forControlEvents: UIControlEvents.ValueChanged)
    }

    func handleRefresh(refreshControl: UIRefreshControl) {
        if let topicListApi = self.topicListApi {
            self.atPage = 1
            topicListApi.getTopicListAtPage(self.atPage) { topicList in
                self.topicList  = topicList
                self.atPage += 1
                refreshControl.endRefreshing()
            }
        }
    }
    
    func handleLoadMore() {
        if let topicListApi = self.topicListApi {
            topicListApi.getTopicListAtPage(self.atPage) { topicList in
                self.topicList  += topicList
                self.atPage += 1
            }
        }
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
        cell.avatarImageView.kf_setImageWithURL(NSURL(string: topic.user.avatar)!, placeholderImage: UIImage(named: "avatar_placeholder"))
        
        if indexPath.row == topicList.count - 5 {
            handleLoadMore()
        }
        
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "TopicDetail" {
            let topicDetail = segue.destinationViewController as! TopicDetailViewController
            
            if let selectedTopicCell = sender as? TopicListTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedTopicCell)!
                let selectedTopic = topicList[indexPath.row]
                topicDetail.topic = selectedTopic
            }
        }
    }
}
