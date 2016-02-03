//
//  CurrentUserHandler.swift
//  PHPHub
//
//  Created by 2014-104 on 16/2/1.
//  Copyright © 2016年 ninerec. All rights reserved.
//

import KeychainAccess
import SwiftyJSON

class CurrentUserHandler {
    static var defaultHandler: CurrentUserHandler!
    var user: User?
    
    private let keychain = Keychain(service: AppConfig.KeyChainService)
    
    static func setDefaultHandler(defaultHandler: CurrentUserHandler) {
        self.defaultHandler = defaultHandler
    }
    
    var isLoggedIn: Bool {
        return user != nil;
    }
    
    init () {
        guard let _ = keychain[AppConfig.KeyChainLoginAccount] else {
            self.user = nil
            return
        }
        
        refreshUserInfo()
    }
    
    func login(username username: String, loginToken: String, callback: Bool -> Void) {
        AuthorizeApi.getLoginAccessToken(username: username, loginToken: loginToken) { json in
            debugPrint(json.rawString())
            if let loginToken = json["access_token"].string {
                self.keychain[AppConfig.KeyChainLoginAccount] = loginToken
                callback(true)
            } else {
                debugPrint("login => wrong return")
                callback(false)
            }
        }
    }
    
    func logout() {
        
    }
    
    func refreshUserInfo() {
        UserApi.getCurrentUser{ user in
            debugPrint(user.username)
            self.user = user
        }
    }
}
