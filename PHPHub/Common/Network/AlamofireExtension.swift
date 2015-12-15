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
    static func collection(jsonData jsonData: JSON) -> [Self]
}

extension Alamofire.Request {
    public func responseObject<T: ResponseObjectSerializable>(completionHandler: Response<T, NSError> -> Void) -> Self {
        let responseSerializer = ResponseSerializer<T, NSError> { request, response, data, error in
            guard error == nil else { return .Failure(error!) }
            
            let JSONResponseSerializer = Request.SwiftyJSONResponseSerializer()
            let result = JSONResponseSerializer.serializeResponse(request, response, data, error)
            
            switch result {
            case .Success(let value):
                if let
                    responseObject = T(jsonData: value)
                {
                    return .Success(responseObject)
                } else {
                    let failureReason = "JSON could not be serialized into response object: \(value)"
                    let error = Error.errorWithCode(.JSONSerializationFailed, failureReason: failureReason)
                    return .Failure(error)
                }
            case .Failure(let error):
                return .Failure(error)
            }
        }
        
        return response(responseSerializer: responseSerializer, completionHandler: completionHandler)
    }
    
    public func responseCollection<T: ResponseCollectionSerializable>(completionHandler: Response<[T], NSError> -> Void) -> Self {
        let responseSerializer = ResponseSerializer<[T], NSError> { request, response, data, error in
            guard error == nil else { return .Failure(error!) }
            
            let JSONSerializer = Request.SwiftyJSONResponseSerializer()
            let result = JSONSerializer.serializeResponse(request, response, data, error)
            
            switch result {
            case .Success(let value):
                if let _ = response {
                    return .Success(T.collection(jsonData: value))
                } else {
                    let failureReason = "Response collection could not be serialized due to nil response"
                    let error = Error.errorWithCode(.JSONSerializationFailed, failureReason: failureReason)
                    return .Failure(error)
                }
            case .Failure(let error):
                return .Failure(error)
            }
        }
        
        return response(responseSerializer: responseSerializer, completionHandler: completionHandler)
    }
}

extension Alamofire.Request {
    public static func SwiftyJSONResponseSerializer() -> ResponseSerializer<JSON, NSError> {
        return ResponseSerializer { request, response, data, error in
            guard error == nil else { return .Failure(error!) }
            
            let JSONResponseSerializer = Request.JSONResponseSerializer(options: .AllowFragments)
            let result = JSONResponseSerializer.serializeResponse(request, response, data, error)
            
            switch result {
            case .Success(let value):
                let json = JSON(value)
                return .Success(json)
            case .Failure(let error):
                return .Failure(error)
            }
        }
    }
    
    public func responseSwiftyJSON(completionHandler: Response<JSON, NSError> -> Void) -> Self {
        return response(responseSerializer: Request.SwiftyJSONResponseSerializer(), completionHandler: completionHandler)
    }
}

