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
    case essential
    case newest
    case hotest
    case jobs
    case wiki
    case user(Int)   // 用户发布的帖子
    case attention(Int) // 关注
    case favorite(Int) // 收藏
    
    var filter: String? {
        switch self {
        case .essential:
            return "excellent"
        case .newest:
            return "newest"
        case .hotest:
            return "vote"
        case .jobs:
            return "jobs"
        case .wiki:
            return "wiki"
        default:
            return nil
        }
    }
    
    func getTopicListAtPage(_ atPage:Int, callback: @escaping ([Topic]) -> Void) {
        var parameters:[String: AnyObject] = [
            "include" : "node,last_reply_user,user" as AnyObject,
            "per_page": 20 as AnyObject,
            "page": atPage as AnyObject,
            "columns": "user(signature)" as AnyObject
        ]

        switch self {
        case .essential, .newest, .hotest, .jobs, .wiki:
            parameters["filters"] = self.filter! as AnyObject?
            ApiHandler.sharedInstance.CollectionRequest(Router.topicList(parameters), callback: callback)
        case .user(let userId):
            ApiHandler.sharedInstance.CollectionRequest(Router.userTopiclist(userId, parameters), callback: callback)
        case .attention(let userId):
            ApiHandler.sharedInstance.CollectionRequest(Router.userAttentionTopiclist(userId, parameters), callback: callback)
        case .favorite(let userId):
            ApiHandler.sharedInstance.CollectionRequest(Router.userFavoriteTopiclist(userId, parameters), callback: callback)
        }
    }
}


class TopicApi {
    class func getTopicListByFilter(_ filter: String, atPage: Int, callback: @escaping ([Topic]) -> Void){
        let parameters:[String: AnyObject] = [
            "include" : "node,last_reply_user,user" as AnyObject,
            "filters": filter as AnyObject,
            "per_page": 20 as AnyObject,
            "page": atPage as AnyObject,
            "columns": "user(signature)" as AnyObject
        ]
        
        ApiHandler.sharedInstance.CollectionRequest(Router.topicList(parameters), callback: callback)
    }
    
    class func getEssentialTopicList(_ atPage: Int, callback: @escaping ([Topic]) -> Void) {
        getTopicListByFilter("excellent", atPage: atPage, callback: callback)
    }
    
    class func getNewestTopicList(_ atPage: Int, callback: @escaping ([Topic]) -> Void) {
        getTopicListByFilter("newest", atPage: atPage, callback: callback)
    }
    
    class func getHotestTopicList(_ atPage: Int, callback: @escaping ([Topic]) -> Void) {
        getTopicListByFilter("vot", atPage: atPage, callback: callback)
    }
    
    class func getJobTopicList(_ atPage: Int, callback: @escaping ([Topic]) -> Void) {
        getTopicListByFilter("jobs", atPage: atPage, callback: callback)
    }
    
    class func getWikiTopicList(_ atPage: Int, callback: @escaping ([Topic]) -> Void) {
        getTopicListByFilter("wiki", atPage: atPage, callback: callback)
    }
    
    class func getTopicDetails(_ topicId: Int, callback: @escaping (String) -> Void) {
        ApiHandler.sharedInstance.StringRequest(Router.topicDetails(topicId), callback: callback)
    }
    
    class func getTopicReplies(_ topicId: Int, callback: @escaping (String) -> Void) {
        ApiHandler.sharedInstance.StringRequest(Router.topicDetails(topicId), callback: callback)
    }
    
    class func getAttentionTopicListByUser(_ userId: Int, atPage: Int, callback: @escaping ([Topic]) -> Void) {
        getTopicListByFilter("attention", atPage: atPage, callback: callback)
    }
}
