//
//  UsersProvider.swift
//  iosui
//
//  Created by vlad on 06.02.2021.
//

import Foundation

class UsersProvider {
    func getUsers() -> [IUser] {
        var users = [IUser]()
        users.append(VkUser(name: "Vlad", lastOnlineDate: "21.12.2020", avatarPath: "avatar_1"))
        users.append(VkUser(name: "Kate", lastOnlineDate: "02.02.2020", avatarPath: "avatar_2"))
        users.append(VkUser(name: "John", lastOnlineDate: "21.01.2020", avatarPath: "avatar_3"))
        users.append(VkUser(name: "Jane", lastOnlineDate: "01.11.2020", avatarPath: "avatar_4"))
        users.append(VkUser(name: "Elza", lastOnlineDate: "21.09.2020", avatarPath: "avatar_5"))
        users.append(VkUser(name: "Michael", lastOnlineDate: "07.04.2020", avatarPath: "avatar_6"))
        users.append(VkUser(name: "Ashley", lastOnlineDate: "23.05.2020", avatarPath: "avatar_7"))
        users.append(VkUser(name: "Romul", lastOnlineDate: "19.03.2020", avatarPath: "avatar_8"))
        users.append(VkUser(name: "Saur", lastOnlineDate: "11.06.2020", avatarPath: "avatar_9"))
        users.append(VkUser(name: "Lautaro", lastOnlineDate: "05.08.2020", avatarPath: "avatar_10"))

        return users
    }
}
