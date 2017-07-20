//
//  AuthorizeApi.swift
//  PHPHub
//
//  Created by 2014-104 on 15/12/13.
//  Copyright © 2015年 ninerec. All rights reserved.
//

import Alamofire
import SwiftyJSON

class AuthorizeApi {
    class func getClientAccessToken(_ callback: @escaping (JSON) -> Void) {
        let parameters:[String: AnyObject] = [
            "grant_type" : "client_credentials" as AnyObject,
            "client_id": AppConfig.Api.Client_id as AnyObject,
            "client_secret": AppConfig.Api.Client_secret as AnyObject
        ]
        
        Alamofire.request(Router.authorize(parameters))
            .responseSwiftyJSON { response in
                switch response.result {
                case .success(let value):
                    callback(value)
                case .failure(let error):
                    debugPrint(error)
                }
        }
    }
    
    class func getLoginAccessToken(username: String, loginToken: String, callback: @escaping (JSON) -> Void) {
        let parameters:[String: AnyObject] = [
            "grant_type" : "login_token" as AnyObject,
            "client_id": AppConfig.Api.Client_id as AnyObject,
            "client_secret": AppConfig.Api.Client_secret as AnyObject,
            "username": username as AnyObject,
            "login_token": loginToken as AnyObject
        ]
        
        Alamofire.request(Router.authorize(parameters))
            .responseSwiftyJSON { response in
                switch response.result {
                case .success(let value):
                    callback(value)
                case .failure(let error):
                    debugPrint(error)
                }
        }
    }
    
    class func refreshLoginAccessToken(_ callback: @escaping (JSON) -> Void) {
        let parameters:[String: AnyObject] = [
            "grant_type" : "refresh_token" as AnyObject,
            "client_id": AppConfig.Api.Client_id as AnyObject,
            "client_secret": AppConfig.Api.Client_secret as AnyObject
        ]
        
        Alamofire.request(Router.authorize(parameters))
            .responseSwiftyJSON { response in
                switch response.result {
                case .success(let value):
                    callback(value)
                case .failure(let error):
                    debugPrint(error)
                }
        }
    }
}
