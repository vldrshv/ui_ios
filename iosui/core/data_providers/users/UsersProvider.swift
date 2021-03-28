//
//  UsersProvider.swift
//  iosui
//
//  Created by vlad on 06.02.2021.
//

import Foundation
import RxSwift

// sections can be collection

class UsersProvider {
    private let api: IUsersApi = VkApi()
    private let disposables = DisposeBag()
    
    private var usersSections = [UserSection]()
    private var lowercasedFilterText: String = ""
    
    public var users = [IUser]()
}

// -------------------------------
// MARK: -- Data Source extension
// -------------------------------

extension UsersProvider {
    func getData(userId: String?, onSuccess: (() -> Void)? = nil) {
        api.getUsersFor(userId: userId)
            .observe(on: MainScheduler.instance)
            .map { data -> [VkUserResponse] in
                let response = JsonWrapper.getVkResponce(data: data) as VkResponse<VkUserResponse>
                return response.getResponseItems()
            }
            .map { items -> Bool in
                self.users.removeAll()
                items.forEach { userResponse in self.users.append(VkUser(userResponse)) }
                return self.users.count > 0
            }
            .subscribe(
                onNext: { isNotEmpty in
                    if isNotEmpty {
                        self.initSections()
                        onSuccess?()
                    }
                },
                onError: { error in print(error.localizedDescription) }
            )
            .disposed(by: disposables)
    }
    
    func getUsersCount() -> Int {
        return users.count
    }
    
    func getAt(index: IndexPath) -> IUser {
        if index.item > getUsersCount() {
            return users.last!
        }
        if index.item < 0 {
            return users.first!
        }
        
        return users[index.item]
    }
    
    func getUserBy(name: String) -> IUser {
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
    
    func getSectionsCount() -> Int {
        if usersSections.count == 0 && getUsersCount() != 0 {
            initSections()
        }
        
        return usersSections.count
    }
    
    func getUsersInSectionCount(section: Int) -> Int {
        if section > getSectionsCount() || section < 0 {
            return 0
        }
        
        return usersSections[section].users.count
    }
    
    func getAtSection(index: IndexPath) -> IUser {
        let section = getSectionAt(section: index.section)
        
        return section.users[index.item]
    }
    
    func getSectionNameAt(section: Int) -> String {
        let section = getSectionAt(section: section)
        return section.sectionName
    }
    
    func initSections() {
        usersSections.removeAll()
        
        for user in users {
            if !user.hasName() { continue }
            
            addWithFilter(element: user)
        }
        
        usersSections.sort(by: { $0.sectionName < $1.sectionName })
    }
    
    func getFirstLetter(user: IUser) -> String {
        return user.getName().isEmpty ? "" : String(user.getName().first!)
    }
    
    func getSectionAt(section: Int) -> UserSection {
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
    func makeSearch(withText: String) {
        if lowercasedFilterText == withText.lowercased() {
            return
        }
        lowercasedFilterText = withText.lowercased()
        usersSections = []
        initSections()
    }
    
    func addWithFilter(element: IUser) {
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
    
    func findSectionFor(user: IUser) -> Int? {
        let firstLetter = getFirstLetter(user: user)
        for sectionIdx in usersSections.indices {
            if usersSections[sectionIdx].sectionName == firstLetter {
                return sectionIdx
            }
        }
        
        return nil
    }
    
    func isAppropriate(text: String) -> Bool {
        return lowercasedFilterText.isEmpty || text.lowercased().contains(lowercasedFilterText)
    }
}
