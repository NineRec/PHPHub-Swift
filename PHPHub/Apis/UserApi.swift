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
    class func getCurrentUser(callback: User -> Void) {
        ApiHandler.sharedInstance.ObjectRequest(Router.CurrentUser, callback: callback)
    }
}


