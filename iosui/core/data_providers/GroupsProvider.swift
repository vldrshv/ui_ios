//
//  GroupsProvider.swift
//  iosui
//
//  Created by vlad on 07.02.2021.
//

import Foundation

class GroupsProvider {
    
    private static var groups: [IGroup] = [
        VkGroup(name: "box", groupImagePath: "box"),
        VkGroup(name: "dc", groupImagePath: "dc"),
        VkGroup(name: "facebook", groupImagePath: "facebook"),
        VkGroup(name: "snowboard", groupImagePath: "snowboard"),
        VkGroup(name: "twitter", groupImagePath: "twitter"),
        VkGroup(name: "volleyball", groupImagePath: "volleyball")
    ]
    
    static func getGroups() -> [IGroup] {
        return groups
    }
    
    static func getUnsubscribedGroups() -> [IGroup] {
        return groups.filter{ !$0.isUserSubscribed() }
    }
    
    static func unsubscribedCount() -> Int {
        return getUnsubscribedGroups().count
    }
    
    static func subscribedCount() -> Int {
        return getSubscribedGroups().count
    }
    
    static func getSubscribedGroups() -> [IGroup] {
        return groups.filter{ $0.isUserSubscribed() }
    }
    
    static func getGroup(at: IndexPath) -> IGroup {
        return getSubscribedGroups()[at.item]
    }
}
