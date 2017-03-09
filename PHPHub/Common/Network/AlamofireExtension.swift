//
//  SwiftyJSONExtension.swift
//  SpeedSwift
//
//  Created by 2014-104 on 15/12/3.
//  Copyright © 2015年 ninerec. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

public protocol ResponseObjectSerializable {
    init?(jsonData: JSON)
}

public protocol ResponseCollectionSerializable {
    static func collection(jsonData: JSON) -> [Self]
}

extension Alamofire.Request {
    public func responseObject<T: ResponseObjectSerializable>(_ completionHandler: (Response<T, NSError>) -> Void) -> Self {
        let responseSerializer = ResponseSerializer<T, NSError> { request, response, data, error in
            guard error == nil else { return .failure(error!) }
            
            let JSONResponseSerializer = Request.SwiftyJSONResponseSerializer()
            let result = JSONResponseSerializer.serializeResponse(request, response, data, error)
            
            switch result {
            case .success(let value):
                if let
                    responseObject = T(jsonData: value["data"])
                {
                    return .success(responseObject)
                } else {
                    let failureReason = "JSON could not be serialized into response object: \(value)"
                    let error = Alamofire.Error.errorWithCode(.jsonSerializationFailed, failureReason: failureReason)
                    return .failure(error)
                }
            case .failure(let error):
                return .failure(error)
            }
        }
        
        return response(responseSerializer: responseSerializer, completionHandler: completionHandler)
    }
    
    public func responseCollection<T: ResponseCollectionSerializable>(_ completionHandler: (Response<[T], NSError>) -> Void) -> Self {
        let responseSerializer = ResponseSerializer<[T], NSError> { request, response, data, error in
            guard error == nil else { return .failure(error!) }
            
            let JSONSerializer = Request.SwiftyJSONResponseSerializer()
            let result = JSONSerializer.serializeResponse(request, response, data, error)
            
            switch result {
            case .success(let value):
                if let _ = response {
                    return .success(T.collection(jsonData: value["data"]))
                } else {
                    let failureReason = "Response collection could not be serialized due to nil response"
                    let error = Alamofire.Error.errorWithCode(.jsonSerializationFailed, failureReason: failureReason)
                    return .failure(error)
                }
            case .failure(let error):
                return .failure(error)
            }
        }
        
        return response(responseSerializer: responseSerializer, completionHandler: completionHandler)
    }
}

extension Alamofire.Request {
    public static func SwiftyJSONResponseSerializer() -> ResponseSerializer<JSON, NSError> {
        return ResponseSerializer { request, response, data, error in
            guard error == nil else { return .failure(error!) }
            
            let JSONResponseSerializer = Request.JSONResponseSerializer(options: .allowFragments)
            let result = JSONResponseSerializer.serializeResponse(request, response, data, error)
            
            switch result {
            case .success(let value):
                let json = JSON(value)
                return .success(json)
            case .failure(let error):
                return .failure(error)
            }
        }
    }
    
    public func responseSwiftyJSON(_ completionHandler: (Response<JSON, NSError>) -> Void) -> Self {
        return response(responseSerializer: Request.SwiftyJSONResponseSerializer(), completionHandler: completionHandler)
    }
}

