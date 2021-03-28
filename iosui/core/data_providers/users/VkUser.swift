//
//  VkUser.swift
//  iosui
//
//  Created by vlad on 06.02.2021.
//

import Foundation


struct VkUser : IUser {
    
    private let user: VkUserResponse?
    
    init(_ response: VkUserResponse?) {
        self.user = response
    }
    
    func getId() -> String? {
        return user?.id == nil ? nil : "\(user!.id)"
    }
    
    func getName() -> String {
        let fn = user?.firstName ?? ""
        let ln = user?.lastName ?? ""
        
        return "\(fn) \(ln)"
    }
    
    func getAvatarPath() -> String {
        return user?.photo50 ?? ""
    }
    
    func getLastOnlineDate() -> String {
        guard let lastSeen = user?.lastSeen else { return "" }
        return "\(lastSeen.time)"
    }
    
    func isEmpty() -> Bool {
        return getName().isEmpty && getAvatarPath().isEmpty
    }
    
    func hasName() -> Bool {
        return !getName().isEmpty
    }
    
    static func empty() -> IUser {
        return VkUser(nil)
    }
}

protocol IUser {
    func getId() -> String?
    func getName() -> String
    func getLastOnlineDate() -> String
    func getAvatarPath() -> String
    
    func isEmpty() -> Bool
    func hasName() -> Bool
}
