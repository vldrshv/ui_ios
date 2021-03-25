//
//  VkApi.swift
//  iosui
//
//  Created by vlad on 21.03.2021.
//

import Foundation

class VkApi : VkApiProtocol {
    private let session: UserSessionProtocol = UserSession.instance
    private let httpSession = URLSession(configuration: URLSessionConfiguration.default)
    
    func getUsersFor(userId: String?) {
        guard let url = getUrl(method: .getUsers, userId: userId) else { return }

        makeRequest(with: url) {
            json in self.log(tag: "getUsersFor", message: json)
        }
    }
    
    func getGroupsFor(userId: String?) {
        guard let url = getUrl(method: .getGroups, userId: userId) else { return }
        
        makeRequest(with: url) {
            json in self.log(tag: "getGroupsFor", message: json)
        }
    }
    
    func getPhotosFor(userId: String?) {
        guard let url = getUrl(method: .getPhotos, userId: userId) else { return }
        
        makeRequest(with: url) {
            json in self.log(tag: "getPhotosFor", message: json)
        }
    }
    
    func getUrl(method: VkRequests, userId: String?) -> URL? {
        let id = (userId == nil ? session.getUserId() : userId) as! String
        let token = session.getToken()
        let appId = session.getAppId()
        switch (method) {
        case .auth:
            return URL(string: RequestFactory.getAuth(appId: appId))
        case .getGroups:
            return URL(string: RequestFactory.getGroups(userId: id, token: token))
        case .getUsers:
            return URL(string: RequestFactory.getUsers(userId: id, token: token))
        case .getPhotos:
            return URL(string: RequestFactory.getPhotos(userId: id, token: token))
        }
    }
    
    private func log(tag: String, message: Any?) {
        print("\(tag): \(message)")
    }
    
    private func makeRequest(with url: URL, onResponse: ((_ json: Any?) -> Void)?) {
        let task = httpSession.dataTask(with: url) {
            (data, response, error) in
            let json = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
            onResponse?(json)
        }
        task.resume()
    }
}

extension VkApi {
    func getSession() -> UserSessionProtocol {
        return session
    }
    
    func setSessionFrom(_ fragment: String?, onSaved: (() -> Void)?) {
        guard let fragment = fragment else { return }
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
        }
            
        guard let token = params["access_token"] else {
            return
        }
        guard let userId = params["user_id"] else {
            return
        }
        
        session.setToken(newToken: token)
        session.setUserId(userId: userId)
        
        session.printData()
        
        onSaved?()
    }
}


class RequestFactory {
    private static let baseUrl = "https://api.vk.com/method/"
    private static let version = "5.130"
    
    static func getAuth(appId: String) -> String {
        return "https://oauth.vk.com/authorize?" +
            "client_id=\(appId)&" +
            "display=mobile&" +
            "redirect_uri=https://oauth.vk.com/blank.html&" +
            "scope=friends,photos,groups&" +
            "response_type=token&" +
            "v=\(version)"
    }
    static func getGroups(userId: String, token: String) -> String {
        return baseUrl + "groups.get?" +
            "user_id=\(userId)&" +
            "extended=1&" +
            "count=3&" +
            "access_token=\(token)&v=\(version)"
    }
    static func getUsers(userId: String, token: String) -> String {
        return baseUrl + "friends.get?" +
            "user_id=\(userId)&" +
            "count=3&" +
            "order=name&" +
            "fields=all&" +
            "access_token=\(token)&v=\(version)"
    }
    static func getPhotos(userId: String, token: String) -> String {
        return baseUrl + "photos.get?" +
            "owner_id=\(userId)&" +
            "rev=1&" +
            "album_id=profile&" +
            "count=5" +
            "&access_token=\(token)&v=\(version)"
        
    }
    
    // MARK: -- SEARCH
    static func searchGroups(toSearch: String, token: String) -> String {
        return baseUrl + "groups.search?" +
            "q=\(toSearch)&" +
            "&access_token=\(token)&v=\(version)"
    }
}
