//
//  Topic.swift
//  PHPHub
//
//  Created by 2014-104 on 15/12/15.
//  Copyright © 2015年 ninerec. All rights reserved.
//

import SwiftyJSON

final class Topic: ResponseObjectSerializable, ResponseCollectionSerializable {
    let topicId: Int
    let topicTitle: String
//    let topicBody: String
    let topicRepliesCount: Int
    let voteCount: Int
    let user: User
    let lastReplyUser: User
    let node: Node
    let topicContentUrl: String
    let topicRepliesUrl: String
    let updateAt: NSDate
    
    init?(jsonData: JSON) {
        topicId = jsonData["id"].intValue
        topicTitle = jsonData["title"].stringValue
        topicRepliesCount = jsonData["reply_count"].intValue
        voteCount = jsonData["vote_count"].intValue
        topicContentUrl = jsonData["links"]["details_web_view"].stringValue
        topicRepliesUrl = jsonData["links"]["replies_web_view"].stringValue
        updateAt = NSDate.convertFromString(jsonData["updated_at"].stringValue)!
        
        node = Node(jsonData: jsonData["node"]["data"])!
        user = User(jsonData: jsonData["user"]["data"])!
        lastReplyUser = User(jsonData: jsonData["last_reply_user"]["data"])!
    }
    
    static func collection(jsonData jsonData: JSON) -> [Topic] {
        var topics: [Topic] = []
        
        for (_, subJson) in jsonData {
            if let topic = Topic(jsonData: subJson) {
                topics.append(topic)
            }
        }
        
        return topics
    }
}

