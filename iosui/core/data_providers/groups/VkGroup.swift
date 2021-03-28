//
//  VkGroup.swift
//  iosui
//
//  Created by vlad on 07.02.2021.
//

import Foundation


class VkGroup : IGroup {

    private let groupResponse: VkGroupsResponse?
    
    init(_ response: VkGroupsResponse) {
        self.groupResponse = response
    }
    
    func getName() -> String {
        return groupResponse?.name ?? ""
    }
    
    func getImagePath() -> String {
        return groupResponse?.photo50 ?? ""
    }
    
    func isEmpty() -> Bool {
        return getName().isEmpty && getImagePath().isEmpty
    }
    
    func isUserSubscribed() -> Bool {
        return (groupResponse?.isMember ?? 0) == 1
    }
    
    func doAction() {
//        if isUserSubscribed() {
//            print("do UN-subscribe for '\(getName())'")
//            unsubscribe()
//        } else {
//            print("do subscribe for '\(getName())'")
//            subscrube()
//        }
    }
    
    private func subscrube() {
//        self.isSubscribed = true
    }
    
    private func unsubscribe() {
//        self.isSubscribed = false
    }
}

protocol IGroup {
    func getName() -> String
    func getImagePath() -> String
    func isEmpty() -> Bool
    func isUserSubscribed() -> Bool
    func doAction()
}
