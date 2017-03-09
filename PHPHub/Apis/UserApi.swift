//
//  UserApi.swift
//  PHPHub
//
//  Created by 2014-104 on 16/1/28.
//  Copyright © 2016年 ninerec. All rights reserved.
//

import Alamofire
import SwiftyJSON

class UserApi {
    class func getCurrentUser(_ callback: (User) -> Void) {
        ApiHandler.sharedInstance.ObjectRequest(Router.currentUser, callback: callback)
    }
    
    class func updateCurrentUser(_ userId: Int, parameters:[String: AnyObject], callback: (User) -> Void) {
        ApiHandler.sharedInstance.ObjectRequest(Router.updateUser(userId, parameters), callback: callback)
    }
}


