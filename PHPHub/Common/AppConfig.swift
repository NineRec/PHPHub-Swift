//
//  AppConfig.swift
//  PHPHub
//
//  Created by 2014-104 on 15/12/9.
//  Copyright © 2015年 ninerec. All rights reserved.
//

struct AppConfig {
    static let Debug = true
    
    struct Api {
        static var ApiBasicUrl:String {
            return Debug ? "https://staging_api.phphub.org/v1" : "https://api.phphub.org/v1"
        }
        static let Client_id = "kHOugsx4dmcXwvVbmLkd"
        static let Client_secret = "PuuFCrF94MloSbSkxpwS"
    }
    
    static let KeyChainService = "PHPHubService"
    static let KeyChainAccount = "com.PHPHub.keychain"
}
