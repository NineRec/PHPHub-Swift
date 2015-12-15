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
    class func getClientAccessToken(callback: JSON -> Void) {
        let parameters:[String: AnyObject] = [
            "grant_type" : "client_credentials",
            "client_id": AppConfig.Api.Client_id,
            "client_secret": AppConfig.Api.Client_secret
        ]
        
        Alamofire.request(Router.Authorize(parameters))
            .responseSwiftyJSON { response in
                switch response.result {
                case .Success(let value):
                    callback(value)
                case .Failure(let error):
                    debugPrint(error)
                }
        }
    }
    
    class func getLoginAccessToken(callback: JSON -> Void) {
        let parameters:[String: AnyObject] = [
            "grant_type" : "client_credentials",
            "client_id": AppConfig.Api.Client_id,
            "client_secret": AppConfig.Api.Client_secret
        ]
        
        Alamofire.request(Router.Authorize(parameters))
            .responseSwiftyJSON { response in
                switch response.result {
                case .Success(let value):
                    callback(value)
                case .Failure(let error):
                    debugPrint(error)
                }
        }
    }
    
    class func refreshLoginAccessToken(callback: JSON -> Void) {
        let parameters:[String: AnyObject] = [
            "grant_type" : "client_credentials",
            "client_id": AppConfig.Api.Client_id,
            "client_secret": AppConfig.Api.Client_secret
        ]
        
        Alamofire.request(Router.Authorize(parameters))
            .responseSwiftyJSON { response in
                switch response.result {
                case .Success(let value):
                    callback(value)
                case .Failure(let error):
                    debugPrint(error)
                }
        }
    }
}
