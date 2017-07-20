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
    
    fileprivate let manager: Alamofire.SessionManager
    
    fileprivate init() {
        let configures = URLSessionConfiguration.default
        configures.timeoutIntervalForRequest = Double(AppConfig.Api.TimeoutIntervals)
        
        manager = Alamofire.SessionManager(configuration: configures)
    }
    
    func StringRequest(_ URLRequest: URLRequestConvertible, callback: @escaping (String) -> Void) {
        manager.request(URLRequest)
            .validate(statusCode: 200..<300)
            .responseString { response in
                switch response.result {
                case .success(let value):
                    callback(value)
                case .failure(let error):
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
    
    func SwiftyJSONRequest(_ URLRequest: URLRequestConvertible, callback: @escaping (JSON) -> Void) {
        manager.request(URLRequest)
            .validate(statusCode: 200..<300)
            .responseSwiftyJSON { response in
                switch response.result {
                case .success(let value):
                    callback(value)
                case .failure(let error):
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
        _ URLRequest: URLRequestConvertible,
        callback: @escaping ([T]) -> Void,
        failure: @escaping (NSError) -> Void = { debugPrint($0) })
    {
        manager.request(URLRequest)
            .validate(statusCode: 200..<300)
            .responseCollection { response in
                switch response.result {
                case .success(let value):
                    callback(value)
                case .failure(let error):
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
    
    func ObjectRequest<T: ResponseObjectSerializable>(
        _ URLRequest: URLRequestConvertible,
        callback: @escaping (T) -> Void,
        failure: @escaping (NSError) -> Void = { debugPrint($0) })
    {
        manager.request(URLRequest)
            .validate(statusCode: 200..<300)
            .responseObject { response in
                switch response.result {
                case .success(let value):
                    callback(value)
                case .failure(let error):
                    debugPrint(error)
                    failure(error)
                }
            }
    }
    
    fileprivate func regainClientAccessToken() {
        let accessTokenHandler = AccessTokenHandler()
        accessTokenHandler.getServerClientAccessToken()
    }
}
