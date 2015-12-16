//
//  Router.swift
//  SpeedSwift
//
//  Created by 2014-104 on 15/12/1.
//  Copyright © 2015年 ninerec. All rights reserved.
//

import Alamofire
import KeychainAccess

enum Router: URLRequestConvertible {
    static var AccessToken: String?
    
    // ImV2 API
    case Authorize([String: AnyObject])
    case TopicList([String: AnyObject])
    
    var method: Alamofire.Method {
        switch self {
        case .Authorize:
            return .POST
        case .TopicList:
            return .GET
        }
    }
    
    var path: String {
        switch self {
        case .Authorize:
            return "/oauth/access_token"
        case .TopicList:
            return "/topics"
        }
    }
    
    // MARK: URLRequestConvertible
    
    var URLRequest: NSMutableURLRequest {
        let URL = NSURL(string: AppConfig.Api.BasicUrl)!
        let mutableURLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(path))
        mutableURLRequest.HTTPMethod = method.rawValue
        
        // Set the Header
        let keychain = Keychain(service: AppConfig.KeyChainService)
        if let token =  keychain[AppConfig.KeyChainClientAccount] {
            mutableURLRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        mutableURLRequest.setValue("application/vnd.PHPHub.v1+json", forHTTPHeaderField: "Accept")
        mutableURLRequest.setValue("iOS", forHTTPHeaderField: "X-Client-Platform")
        
        switch self {
        case .Authorize(let parameters):
            return Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: parameters).0
        case .TopicList(let parameters):
            return Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: parameters).0
        }
    }
}