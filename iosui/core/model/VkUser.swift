//
//  VkUser.swift
//  iosui
//
//  Created by vlad on 06.02.2021.
//

import Foundation


class VkUser : IUser {
    private var name: String? = ""
    private var lastOnlineDate: String = ""
    private var avatarPath: String? = ""
    
    init(name: String, lastOnlineDate: String, avatarPath: String) {
        self.name = name
        self.lastOnlineDate = lastOnlineDate
        self.avatarPath = avatarPath
    }
    
    func getName() -> String {
        return name ?? ""
    }
    
    func getAvatarPath() -> String {
        return avatarPath ?? ""
    }
    
    func getLastOnlineDate() -> String {
        return lastOnlineDate
    }
    
    func isEmpty() -> Bool {
        return getName().isEmpty && getAvatarPath().isEmpty
    }
}

protocol IUser {
    func getName() -> String
    func getLastOnlineDate() -> String
    func getAvatarPath() -> String
    func isEmpty() -> Bool
}
