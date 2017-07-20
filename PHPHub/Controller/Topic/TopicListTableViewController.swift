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
        refreshControl?.addTarget(self, action: #selector(TopicListTableViewController.handleRefresh(_:)), for: UIControlEvents.valueChanged)
    }

    func handleRefresh(_ refreshControl: UIRefreshControl) {
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
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topicList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "TopicListCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! TopicListTableViewCell
        
        let topic = topicList[(indexPath as NSIndexPath).row]
        cell.topicTitleLabel.text = topic.topicTitle
        cell.topicInfoLabel.text = "\(topic.node.nodeName) • 最后由 \(topic.lastReplyUser.username) • \(topic.updateAt.timeAgoSinceNow())"
        cell.topicRepliesCountLabel.text = String(topic.topicRepliesCount)
        cell.avatarImageView.kf.setImage(with: URL(string: topic.user.avatar)!, placeholder: UIImage(named: "avatar_placeholder"))
        
        if (indexPath as NSIndexPath).row == topicList.count - 5 {
            handleLoadMore()
        }
        
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TopicDetail" {
            let topicDetail = segue.destination as! TopicDetailViewController
            
            if let selectedTopicCell = sender as? TopicListTableViewCell {
                let indexPath = tableView.indexPath(for: selectedTopicCell)!
                let selectedTopic = topicList[(indexPath as NSIndexPath).row]
                topicDetail.topic = selectedTopic
            }
        }
    }
}
