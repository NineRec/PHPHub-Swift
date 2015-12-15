//
//  Router.swift
//  SpeedSwift
//
//  Created by 2014-104 on 15/12/1.
//  Copyright © 2015年 ninerec. All rights reserved.
//

import Alamofire

enum Router: URLRequestConvertible {
    static var AccessToken: String?
    
    // ImV2 API
    case Authorize([String: AnyObject])
    case TopicList([String: AnyObject])
    
    var method: Alamofire.Method {
        switch self {
        case .Authorize:
            return .POST
        default:
            return .GET
        }
    }
    
    var path: String {
        switch self {
        case .Authorize:
            return "/oauth/access_token"
        case .TopicList:
            return "/topic"
        }
    }
    
    // MARK: URLRequestConvertible
    
    var URLRequest: NSMutableURLRequest {
        let URL = NSURL(string: AppConfig.Api.BasicUrl)!
        let mutableURLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(path))
        mutableURLRequest.HTTPMethod = method.rawValue
        
        switch self {
        case .Authorize(let parameters):
            return Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: parameters).0
        default:
            return mutableURLRequest
        }
    }
}