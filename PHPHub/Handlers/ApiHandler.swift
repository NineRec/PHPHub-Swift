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
            .responseSwiftyJSON { response in
                switch response.result {
                case .Success(let value):
                    callback(value)
                case .Failure(let error):
                    debugPrint(error)
                }
        }
    }
    
    func CollectionRequest<T: ResponseCollectionSerializable>(
        URLRequest: URLRequestConvertible,
        callback: [T] -> Void,
        failure: NSError -> Void = { debugPrint($0) })
    {
        manager.request(URLRequest)
            .responseCollection { (response: Response<[T], NSError>) in
                switch response.result {
                case .Success(let value):
                    callback(value)
                case .Failure(let error):
                    failure(error)
                }
            }
        }
}
