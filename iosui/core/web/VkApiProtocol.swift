//
//  VkAPI.swift
//  iosui
//
//  Created by vlad on 21.03.2021.
//

import Foundation
import RxSwift

protocol VkApiProtocol : IGroupsApi, ISessionApi, IUsersApi, IPhotoApi { }

protocol IGroupsApi {
    func getGroupsFor(userId: String?) -> Observable<Data>
    func searchGroups(text: String) -> Observable<Data>
}

protocol ISessionApi {
    func getUrl(method: VkRequests, userId: String?) -> String
    func getSession() -> UserSessionProtocol
    func setSessionFrom(_ fragment: String?, onSaved: (() -> Void)?)
}

protocol IUsersApi {
    func getUsersFor(userId: String?) -> Observable<Data>
}

protocol IPhotoApi {
    func getPhotosFor(userId: String?) -> Observable<Data>
}

enum VkRequests {
    case auth, getUsers, getGroups, getPhotos, searchGroups
}
