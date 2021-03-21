//
//  UserSession.swift
//  iosui
//
//  Created by vlad on 21.03.2021.
//

import Foundation


class UserSession {
    static var instance: UserSession = UserSession()
    
    private var token: String = ""
    private var userId: String = ""
    
    init() { }
}
