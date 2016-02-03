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
        static var BasicUrl:String {
            return Debug ? "https://staging_api.phphub.org/v1" : "https://api.phphub.org/v1"
        }
        static let Client_id = "kHOugsx4dmcXwvVbmLkd"
        static let Client_secret = "PuuFCrF94MloSbSkxpwS"
        
        static let TimeoutIntervals = 10
    }
    
    static let viewControllerClassesThatRequireLogin: [AnyObject.Type] = [MeTableViewController.self]
    
    static let KeyChainService = "PHPHubService"
    static let KeyChainClientAccount = "com.PHPHub.client"
    static let KeyChainLoginAccount = "com.PHPHub.login"
//    static let keychainExpire = "com.PHPHub.expire"
    
    static let LoginGuide = "http://7xnqwn.com1.z0.glb.clouddn.com/index.html"
}
