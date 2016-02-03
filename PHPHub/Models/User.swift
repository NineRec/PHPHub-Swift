//
//  User.swift
//  PHPHub
//
//  Created by 2014-104 on 15/12/15.
//  Copyright © 2015年 ninerec. All rights reserved.
//

import SwiftyJSON

final class User: ResponseObjectSerializable{
    let userId: Int
    let githubURL: String
    let username: String
    let avatar: String
    let topicCount: Int
    let replyCount: Int
    let notificationCount: Int
    let twitterAccount: String
    let blogURL: String
    let company: String
    let city: String
    let email: String
    let signature: String
    let githubName: String
    let realName: String
    let createdAtDate: String
    let updatedAtDate: String
    
    init?(jsonData: JSON) {
        userId = jsonData["id"].intValue
        username = jsonData["name"].stringValue
        avatar = jsonData["avatar"].stringValue
        topicCount = jsonData["topic_count"].intValue
        replyCount = jsonData["reply_count"].intValue
        notificationCount = jsonData["notification_count"].intValue
        twitterAccount = jsonData["twitter_account"].stringValue
        company = jsonData["company"].stringValue
        city = jsonData["city"].stringValue
        email = jsonData["emai"].stringValue
        signature = jsonData["signature"].stringValue
        githubName = jsonData["github_name"].stringValue
        githubURL = jsonData["github_url"].stringValue
        realName = jsonData["real_name"].stringValue
        blogURL = jsonData["personal_website"].stringValue
        createdAtDate = jsonData["created_at"].stringValue
        updatedAtDate = jsonData["updated_at"].stringValue
    }
}


