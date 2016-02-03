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
    case TopicDetails(Int)
    case TopicReplies(Int)
    case CurrentUser
    
    var method: Alamofire.Method {
        switch self {
        case .Authorize:
            return .POST
        case .TopicList:
            return .GET
        default:
            return .GET
        }
    }
    
    var path: String {
        switch self {
        case .Authorize:
            return "/oauth/access_token"
        case .TopicList:
            return "/topics"
        case .TopicDetails(let topicId):
            return "/topics/\(topicId)/web_view"
        case .TopicReplies(let topicId):
            return "/topics/\(topicId)/replies/web_view"
        case .CurrentUser:
            return "/me"
        }
    }
    
    // MARK: URLRequestConvertible
    
    var URLRequest: NSMutableURLRequest {
        switch self {
        case .Authorize(let parameters):
            return Alamofire.ParameterEncoding.URL.encode(getClientRequest(), parameters: parameters).0
        case .TopicList(let parameters):
            return Alamofire.ParameterEncoding.URL.encode(getClientRequest(), parameters: parameters).0
        case .CurrentUser:
            return Alamofire.ParameterEncoding.URL.encode(getLoginRequest(), parameters: nil).0
        default:
            return Alamofire.ParameterEncoding.URL.encode(getClientRequest(), parameters: nil).0
        }
    }
    
    func getClientRequest() -> NSURLRequest {
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
        
        return mutableURLRequest
    }
    
    func getLoginRequest() -> NSURLRequest {
        let URL = NSURL(string: AppConfig.Api.BasicUrl)!
        let mutableURLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(path))
        mutableURLRequest.HTTPMethod = method.rawValue
        
        // Set the Header
        let accessTokenHandler = AccessTokenHandler()
        if let token =  accessTokenHandler.getLocalLoginAccessToken() {
            debugPrint(token)
            mutableURLRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        mutableURLRequest.setValue("application/vnd.PHPHub.v1+json", forHTTPHeaderField: "Accept")
        mutableURLRequest.setValue("iOS", forHTTPHeaderField: "X-Client-Platform")
        
        return mutableURLRequest
    }
}