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
    private var photos = PhotoProvider.getPhotoPaths(
        photoCount: Int.random(in: 0...10)
    )
    
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
    
    func getPhotoCount() -> Int {
        return photos.count
    }
    
    func getPhotoPathAt(index: Int) -> String {
        return photos[index]
    }
    
    func isEmpty() -> Bool {
        return getName().isEmpty && getAvatarPath().isEmpty
    }
    
    func hasName() -> Bool {
        return !getName().isEmpty
    }
    
    static func empty() -> IUser {
        return VkUser(name: "", lastOnlineDate: "", avatarPath: "")
    }
}

protocol IUser {
    func getName() -> String
    func getLastOnlineDate() -> String
    func getAvatarPath() -> String
    func getPhotoCount() -> Int
    
    func getPhotoPathAt(index: Int) -> String
    
    func isEmpty() -> Bool
    func hasName() -> Bool
}
