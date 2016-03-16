//
//  Topic.swift
//  PHPHub
//
//  Created by 2014-104 on 15/12/15.
//  Copyright © 2015年 ninerec. All rights reserved.
//

import Alamofire
import SwiftyJSON

enum TopicListApi {
    case Essential
    case Newest
    case Hotest
    case Jobs
    case Wiki
    case User(Int)   // 用户发布的帖子
    case Attention(Int) // 关注
    case Favorite(Int) // 收藏
    
    var filter: String? {
        switch self {
        case .Essential:
            return "excellent"
        case .Newest:
            return "newest"
        case .Hotest:
            return "vote"
        case .Jobs:
            return "jobs"
        case .Wiki:
            return "wiki"
        default:
            return nil
        }
    }
    
    func getTopicListAtPage(atPage:Int, callback: [Topic] -> Void) {
        var parameters:[String: AnyObject] = [
            "include" : "node,last_reply_user,user",
            "per_page": 20,
            "page": atPage,
            "columns": "user(signature)"
        ]

        switch self {
        case .Essential, .Newest, .Hotest, .Jobs, .Wiki:
            parameters["filters"] = self.filter!
            ApiHandler.sharedInstance.CollectionRequest(Router.TopicList(parameters), callback: callback)
        case .User(let userId):
            ApiHandler.sharedInstance.CollectionRequest(Router.UserTopiclist(userId, parameters), callback: callback)
        case .Attention(let userId):
            ApiHandler.sharedInstance.CollectionRequest(Router.UserAttentionTopiclist(userId, parameters), callback: callback)
        case .Favorite(let userId):
            ApiHandler.sharedInstance.CollectionRequest(Router.UserFavoriteTopiclist(userId, parameters), callback: callback)
        }
    }
}


class TopicApi {
    class func getTopicListByFilter(filter: String, atPage: Int, callback: [Topic] -> Void){
        let parameters:[String: AnyObject] = [
            "include" : "node,last_reply_user,user",
            "filters": filter,
            "per_page": 20,
            "page": atPage,
            "columns": "user(signature)"
        ]
        
        ApiHandler.sharedInstance.CollectionRequest(Router.TopicList(parameters), callback: callback)
    }
    
    class func getEssentialTopicList(atPage: Int, callback: [Topic] -> Void) {
        getTopicListByFilter("excellent", atPage: atPage, callback: callback)
    }
    
    class func getNewestTopicList(atPage: Int, callback: [Topic] -> Void) {
        getTopicListByFilter("newest", atPage: atPage, callback: callback)
    }
    
    class func getHotestTopicList(atPage: Int, callback: [Topic] -> Void) {
        getTopicListByFilter("vot", atPage: atPage, callback: callback)
    }
    
    class func getJobTopicList(atPage: Int, callback: [Topic] -> Void) {
        getTopicListByFilter("jobs", atPage: atPage, callback: callback)
    }
    
    class func getWikiTopicList(atPage: Int, callback: [Topic] -> Void) {
        getTopicListByFilter("wiki", atPage: atPage, callback: callback)
    }
    
    class func getTopicDetails(topicId: Int, callback: String -> Void) {
        ApiHandler.sharedInstance.StringRequest(Router.TopicDetails(topicId), callback: callback)
    }
    
    class func getTopicReplies(topicId: Int, callback: String -> Void) {
        ApiHandler.sharedInstance.StringRequest(Router.TopicDetails(topicId), callback: callback)
    }
    
    class func getAttentionTopicListByUser(userId: Int, atPage: Int, callback: [Topic] -> Void) {
        getTopicListByFilter("attention", atPage: atPage, callback: callback)
    }
}
