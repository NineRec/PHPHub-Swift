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
    class func SwiftyJSONRequest(URLRequest: URLRequestConvertible, callback: JSON -> Void) {
        Alamofire.request(URLRequest)
            .responseSwiftyJSON { response in
                switch response.result {
                case .Success(let value):
                    callback(value)
                case .Failure(let error):
                    debugPrint(error)
                }
        }
    }
    
    class func CollectionRequest<T: ResponseCollectionSerializable>(
        URLRequest: URLRequestConvertible,
        callback: [T] -> Void)
    {
        Alamofire.request(URLRequest)
            .responseSwiftyJSON{ response in
                debugPrint(response.result.value)
            }
            .responseCollection { (response: Response<[T], NSError>) in
                switch response.result {
                case .Success(let value):
                    callback(value)
                case .Failure(let error):
                    debugPrint(error)
                }
        }
    }
}
