//
//  VkGroup.swift
//  iosui
//
//  Created by vlad on 07.02.2021.
//

import Foundation


class VkGroup : IGroup {
    private var name: String? = ""
    private var groupImagePath: String? = ""
    private var isSubscribed: Bool = true
    
    
    init(name: String, groupImagePath: String) {
        self.name = name
        self.groupImagePath = groupImagePath
    }
    
    func getName() -> String {
        return name ?? ""
    }
    
    func getImagePath() -> String {
        return groupImagePath ?? ""
    }
    
    func isEmpty() -> Bool {
        return getName().isEmpty && getImagePath().isEmpty
    }
    
    func isUserSubscribed() -> Bool {
        return isSubscribed
    }
    
    func doAction() {
        if isSubscribed {
            print("do UN-subscribe for '\(getName())'")
            unsubscribe()
        } else {
            print("do subscribe for '\(getName())'")
            subscrube()
        }
    }
    
    private func subscrube() {
        self.isSubscribed = true
    }
    
    private func unsubscribe() {
        self.isSubscribed = false
    }
}

protocol IGroup {
    func getName() -> String
    func getImagePath() -> String
    func isEmpty() -> Bool
    func isUserSubscribed() -> Bool
    func doAction()
}
