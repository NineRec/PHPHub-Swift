//
//  TopicListTableViewController.swift
//  PHPHub
//
//  Created by 2014-104 on 15/12/9.
//  Copyright © 2015年 ninerec. All rights reserved.
//

import UIKit

class TopicListTableViewController: UITableViewController {

    struct Topic {
        var title: String?
        var info: String?
        var replies: Int?
        var avatar: UIImage?
    }
    
    var topicList = [Topic]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.clearsSelectionOnViewWillAppear = true
        
        // pull to refresh
        refreshControl?.addTarget(self, action: "handleRefresh:", forControlEvents: UIControlEvents.ValueChanged)
        
        // temp the data
        let topic1 = Topic(title: "Test", info: "TESTINFO", replies: 12, avatar: UIImage(named: "avatar_placeholder"))
        let topic2 = Topic(title: "Test", info: "TESTINFO", replies: 12, avatar: UIImage(named: "avatar_placeholder"))
        let topic3 = Topic(title: "Test", info: "TESTINFO", replies: 12, avatar: UIImage(named: "avatar_placeholder"))
        
        topicList.append(topic1)
        topicList.append(topic2)
        topicList.append(topic3)
    }

    func handleRefresh(refreshControl: UIRefreshControl) {
        let topic4 = Topic(title: "Test", info: "TESTINFO", replies: 12, avatar: UIImage(named: "avatar_placeholder"))
        topicList.append(topic4)
        
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
        cell.topicTitleLabel.text = topic.title!
        cell.topicInfoLabel.text = topic.info!
        cell.topicRepliesCountLabel.text = String(topic.replies!)
        cell.avatarImageView.image = topic.avatar
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
