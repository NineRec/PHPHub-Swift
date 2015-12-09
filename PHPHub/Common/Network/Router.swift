//
//  Router.swift
//  SpeedSwift
//
//  Created by 2014-104 on 15/12/1.
//  Copyright © 2015年 ninerec. All rights reserved.
//

import Alamofire

enum Router: URLRequestConvertible {
    static let baseURLString = "https://staging_api.phphub.org/v1"
    static var AccessToken: String?
    
    // ImV2 API
    case Authorize([String: AnyObject])
    case Login([String: AnyObject])
    case ForgetPassword
    case BusInfo
    
    
    var method: Alamofire.Method {
        switch self {
        case .Authorize,
            .Login:
            return .POST
        default:
            return .GET
        }
    }
    
    var path: String {
        switch self {
        case .Authorize:
            return "/auth/authorize"
        case .Login:
            return "/auth/login"
        case .BusInfo:
            return "/users"
        case .ForgetPassword:
            return "/users/"
        }
    }
    
    // MARK: URLRequestConvertible
    
    var URLRequest: NSMutableURLRequest {
        let URL = NSURL(string: Router.baseURLString)!
        let mutableURLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(path))
        mutableURLRequest.HTTPMethod = method.rawValue
        
        let token = Router.AccessToken ?? ""
        
        switch self {
        case .Authorize(let parameters):
            return Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: parameters).0
        case .Login(let parameters):
            return Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: parameters).0
        default:
            return mutableURLRequest
        }
    }
}