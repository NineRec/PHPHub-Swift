//
//  ApiHandler.swift
//  PHPHub
//
//  Created by 2014-104 on 15/12/15.
//  Copyright © 2015年 ninerec. All rights reserved.
//

import Alamofire
import SwiftyJSON

class ApiHandler {
    static let sharedInstance = ApiHandler()
    
    private let manager: Alamofire.Manager
    
    private init() {
        let configures = NSURLSessionConfiguration.defaultSessionConfiguration()
        configures.timeoutIntervalForRequest = Double(AppConfig.Api.TimeoutIntervals)
        
        manager = Alamofire.Manager(configuration: configures)
    }
    
    func SwiftyJSONRequest(URLRequest: URLRequestConvertible, callback: JSON -> Void) {
        manager.request(URLRequest)
            .validate(statusCode: 200..<300)
            .responseSwiftyJSON { response in
                switch response.result {
                case .Success(let value):
                    callback(value)
                case .Failure(let error):
                    debugPrint(error)
                    
                    if let URLResponse = response.response {
                        if URLResponse.statusCode == 401 {
                            self.regainClientAccessToken()
                            self.SwiftyJSONRequest(URLRequest, callback: callback)
                        }
                    }
                }
        }
    }
    
    func CollectionRequest<T: ResponseCollectionSerializable>(
        URLRequest: URLRequestConvertible,
        callback: [T] -> Void,
        failure: NSError -> Void = { debugPrint($0) })
    {
        manager.request(URLRequest)
            .validate(statusCode: 200..<300)
            .responseCollection { (response: Response<[T], NSError>) in
                switch response.result {
                case .Success(let value):
                    callback(value)
                case .Failure(let error):
                    failure(error)
                    
                    if let URLResponse = response.response {
                        if URLResponse.statusCode == 401 {
                            self.regainClientAccessToken()
                            self.CollectionRequest(URLRequest, callback: callback, failure: failure)
                        }
                    }
                }
            }
    }
    
    func StringRequest(URLRequest: URLRequestConvertible, callback: String -> Void) {
        manager.request(URLRequest)
            .validate(statusCode: 200..<300)
            .responseString { response in
                switch response.result {
                case .Success(let value):
                    callback(value)
                case .Failure(let error):
                    debugPrint(error)
                    
                    if let URLResponse = response.response {
                        if URLResponse.statusCode == 401 {
                            self.regainClientAccessToken()
                            self.StringRequest(URLRequest, callback: callback)
                        }
                    }
                }
        }
    }
    
    private func regainClientAccessToken() {
        let accessTokenHandler = AccessTokenHandler()
        accessTokenHandler.getServerClientAccessToken()
    }
}
