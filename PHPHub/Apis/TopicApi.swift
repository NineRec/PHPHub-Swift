//
//  Topic.swift
//  PHPHub
//
//  Created by 2014-104 on 15/12/15.
//  Copyright © 2015年 ninerec. All rights reserved.
//

import Alamofire
import SwiftyJSON

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
}
