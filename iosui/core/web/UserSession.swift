//
//  UserSession.swift
//  iosui
//
//  Created by vlad on 21.03.2021.
//

import Foundation


class UserSession : UserSessionProtocol {
    static var instance: UserSession = UserSession()
    
    private var token: String = ""
    private var userId: String = ""
    
    private let appId = "7798149"
    
    private init() {}
    
    func setToken(newToken: String) {
        self.token = newToken
    }
    func setUserId(userId: String) {
        self.userId = userId
    }
    
    func getToken() -> String { return token }
    func getUserId() -> String { return userId }
    func getAppId() -> String { return appId }
    
    func printData() {
        print("----------- User Session: ------------")
        print("'token' -> '\(self.token)'")
        print("'user_id' -> '\(self.userId)'")
        print("'app_id' -> '\(self.appId)'")
        print("======================================")
    }
}

protocol UserSessionProtocol {
    func setToken(newToken: String)
    func setUserId(userId: String)
    
    func getToken() -> String
    func getUserId() -> String
    func getAppId() -> String
    
    func printData()
}
