//
//  UsersProvider.swift
//  iosui
//
//  Created by vlad on 06.02.2021.
//

import Foundation

// sections can be collection

class UsersProvider {
    private static var usersSections = [UserSection]()
    
    public static var users = [
        VkUser(name: "Vlad", lastOnlineDate: "21.12.2020", avatarPath: "avatar_1"),
        VkUser(name: "Kate", lastOnlineDate: "02.02.2020", avatarPath: "avatar_2"),
        VkUser(name: "John", lastOnlineDate: "21.01.2020", avatarPath: "avatar_3"),
        VkUser(name: "Jane", lastOnlineDate: "01.11.2020", avatarPath: "avatar_4"),
        VkUser(name: "Elza", lastOnlineDate: "21.09.2020", avatarPath: "avatar_5"),
        VkUser(name: "Michael", lastOnlineDate: "07.04.2020", avatarPath: "avatar_6"),
        VkUser(name: "Ashley", lastOnlineDate: "23.05.2020", avatarPath: "avatar_7"),
        VkUser(name: "Romul", lastOnlineDate: "19.03.2020", avatarPath: "avatar_8"),
        VkUser(name: "Saur", lastOnlineDate: "11.06.2020", avatarPath: "avatar_9"),
        VkUser(name: "Lautaro", lastOnlineDate: "05.08.2020", avatarPath: "avatar_10")
    ]
    
    public static func getUsersCount() -> Int {
        return users.count
    }
    
    public static func getAt(index: IndexPath) -> IUser {
        if index.item > getUsersCount() {
            return users.last!
        }
        if index.item < 0 {
            return users.first!
        }
        
        return users[index.item]
    }
    
    
    // MARK: -- SECTIONS
    
    public static func getSectionsCount() -> Int {
        if usersSections.count == 0 && getUsersCount() != 0 {
            initSections()
        }
        
        return usersSections.count
    }
    
    public static func getUsersInSectionCount(section: Int) -> Int {
        if section > getSectionsCount() || section < 0 {
            return 0
        }
        
        return usersSections[section].users.count
    }
    
    public static func getAtSection(index: IndexPath) -> IUser {
        let section = getSectionAt(section: index.section)
        
        return section.users[index.item]
    }
    
    public static func getSectionNameAt(section: Int) -> String {
        let section = getSectionAt(section: section)
        return section.sectionName
    }
    
    private static func initSections() {
        for user in users {
            let firstLetter = getFirstLetter(user: user)
            
            if firstLetter.isEmpty { continue }

            for sectionIdx in usersSections.indices {
                if usersSections[sectionIdx].sectionName == firstLetter {
                    usersSections[sectionIdx].users.append(user)
                    break
                }
            }
            
            usersSections.append(UserSection(name: firstLetter, users: [user]))
        }
        
        usersSections.sort(by: { $0.sectionName < $1.sectionName })
    }
    
    private static func getFirstLetter(user: IUser) -> String {
        return user.getName().isEmpty ? "" : String(user.getName().first!)
    }
    
    private static func getSectionAt(section: Int) -> UserSection {
        if section > getSectionsCount() {
            return usersSections.last!
        }
        if section < 0 {
            return usersSections.first!
        }
        
        return usersSections[section]
    }
}

enum UserProviderError : Error {
    case outOfIndexError
}

struct UserSection {
    let sectionName: String
    var users = [IUser]()
    
    init(name: String) {
        self.sectionName = name
    }
    
    init(name: String, users: [IUser]) {
        self.sectionName = name
        self.users = users
    }
}
