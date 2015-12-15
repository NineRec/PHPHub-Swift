//
//  AccessTokenHandler.swift
//  PHPHub
//
//  Created by 2014-104 on 15/12/14.
//  Copyright © 2015年 ninerec. All rights reserved.
//

import KeychainAccess
import SwiftyJSON

class AccessTokenHandler {
    let keychain = Keychain(service: AppConfig.KeyChainService)
    
    func getLocalClientAccessToken() -> String? {
        return keychain[AppConfig.KeyChainClientAccount]
    }
    
    func getServerClientAccessToken() {
        AuthorizeApi.getClientAccessToken { json in
            self.storeClientAccessToken(json["access_token"].stringValue)
        }
    }
    
    func getLocalLoginAccessToken() -> String? {
        return keychain[AppConfig.KeyChainLoginAccount]
    }
    
    func getServerLoginAccessToken() {
        AuthorizeApi.getLoginAccessToken { json in
            self.storeLoginAccessToken(json["access_token"].stringValue)
        }
    }
    
    func storeClientAccessToken(accessToken: String) {
        keychain[AppConfig.KeyChainClientAccount] = accessToken
    }
    
    func storeLoginAccessToken(accessToken: String) {
        keychain[AppConfig.KeyChainLoginAccount] = accessToken
    }
}
