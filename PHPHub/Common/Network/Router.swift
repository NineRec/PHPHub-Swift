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
    case authorize([String: AnyObject])
    case topicList([String: AnyObject])
    case topicDetails(Int)
    case topicReplies(Int)
    case currentUser
    case updateUser(Int, [String: AnyObject])
    case userTopiclist(Int, [String: AnyObject])
    case userAttentionTopiclist(Int, [String: AnyObject])
    case userFavoriteTopiclist(Int, [String: AnyObject])
    
    var method: HTTPMethod {
        switch self {
        case .authorize:
            return .post
        case .topicList:
            return .get
        case .updateUser:
            return .put
        default:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .authorize:
            return "/oauth/access_token"
        case .topicList:
            return "/topics"
        case .topicDetails(let topicId):
            return "/topics/\(topicId)/web_view"
        case .topicReplies(let topicId):
            return "/topics/\(topicId)/replies/web_view"
        case .currentUser:
            return "/me"
        case .updateUser(let userId, _):
            return "/users/\(userId)"
        case .userTopiclist(let userId, _):
            return "/user/\(userId)/topics"
        case .userAttentionTopiclist(let userId, _):
            return "/user/\(userId)/attention/topics"
        case .userFavoriteTopiclist(let userId, _):
            return "/user/\(userId)/favorite/topics"
        }
    }
    
    // MARK: URLRequestConvertible
    
    func asURLRequest() throws -> URLRequest {
        switch self {
        case .authorize(let parameters):
            return try URLEncoding.default.encode(getClientRequest(), with: parameters)
        case .topicList(let parameters):
            return try URLEncoding.default.encode(getClientRequest(), with: parameters)
        case .userTopiclist(_, let parameters):
            return try URLEncoding.default.encode(getLoginRequest(), with: parameters)
        case .userAttentionTopiclist(_, let parameters):
            return try URLEncoding.default.encode(getLoginRequest(), with: parameters)
        case .userFavoriteTopiclist(_, let parameters):
            return try URLEncoding.default.encode(getLoginRequest(), with: parameters)
        case .currentUser:
            return try URLEncoding.default.encode(getLoginRequest(), with: nil)
        case .updateUser(_, let parameters):
            return try URLEncoding.default.encode(getLoginRequest(), with: parameters)
        default:
            return try URLEncoding.default.encode(getClientRequest(), with: nil)
        }
    }
    
    func getClientRequest() -> Foundation.URLRequest {
        let URL = Foundation.URL(string: AppConfig.Api.BasicUrl)!
        let mutableURLRequest = NSMutableURLRequest(url: URL.appendingPathComponent(path))
        mutableURLRequest.httpMethod = method.rawValue
        
        // Set the Header
        let keychain = Keychain(service: AppConfig.KeyChainService)
        if let token =  keychain[AppConfig.KeyChainClientAccount] {
            mutableURLRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        mutableURLRequest.setValue("application/vnd.PHPHub.v1+json", forHTTPHeaderField: "Accept")
        mutableURLRequest.setValue("iOS", forHTTPHeaderField: "X-Client-Platform")
        
        return mutableURLRequest as URLRequest
    }
    
    func getLoginRequest() -> Foundation.URLRequest {
        let URL = Foundation.URL(string: AppConfig.Api.BasicUrl)!
        let mutableURLRequest = NSMutableURLRequest(url: URL.appendingPathComponent(path))
        mutableURLRequest.httpMethod = method.rawValue
        
        // Set the Header
        let accessTokenHandler = AccessTokenHandler()
        if let token =  accessTokenHandler.getLocalLoginAccessToken() {
            mutableURLRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        mutableURLRequest.setValue("application/vnd.PHPHub.v1+json", forHTTPHeaderField: "Accept")
        mutableURLRequest.setValue("iOS", forHTTPHeaderField: "X-Client-Platform")
        
        return mutableURLRequest as URLRequest
    }
}
