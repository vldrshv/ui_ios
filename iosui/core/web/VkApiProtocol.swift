//
//  VkAPI.swift
//  iosui
//
//  Created by vlad on 21.03.2021.
//

import Foundation

protocol VkApiProtocol {
    func getUsersFor(userId: String?)
    func getGroupsFor(userId: String?)
    
    func getUrl(method: VkRequests, userId: String?) -> URL?
    func getSession() -> UserSessionProtocol
    func setSessionFrom(_ fragment: String?, onSaved: (() -> Void)?)
}

enum VkRequests {
    case auth, getUsers, getGroups, getPhotos, searchGroups
}
