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
    private static var lowercasedFilterText: String = ""
    
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
    
    static func getUserBy(name: String) -> IUser {
        if name == "" {
            return VkUser.empty()
        }
        
        for user in users {
            if user.getName() == name {
                return user
            }
        }
        
        return VkUser.empty()
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
            if !user.hasName() { continue }
            
            addWithFilter(element: user)
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

// ------------------
// MARK: -- SEARCHING
// ------------------

extension UsersProvider {
    public static func makeSearch(withText: String) {
        if lowercasedFilterText == withText.lowercased() {
            return
        }
        lowercasedFilterText = withText.lowercased()
        usersSections = []
        initSections()
    }
    
    private static func addWithFilter(element: IUser) {
        let toSection = findSectionFor(user: element)
        guard let nonNullSection = toSection else {
            if isAppropriate(text: element.getName()) {
                usersSections.append(
                    UserSection(name: getFirstLetter(user: element), users: [element])
                )
            }
            return
        }
        
        if isAppropriate(text: element.getName()) {
            usersSections[nonNullSection].users.append(element)
        }
    }
    
    private static func findSectionFor(user: IUser) -> Int? {
        let firstLetter = getFirstLetter(user: user)
        for sectionIdx in usersSections.indices {
            if usersSections[sectionIdx].sectionName == firstLetter {
                return sectionIdx
            }
        }
        
        return nil
    }
    
    private static func isAppropriate(text: String) -> Bool {
        return lowercasedFilterText.isEmpty || text.lowercased().contains(lowercasedFilterText)
    }
}
