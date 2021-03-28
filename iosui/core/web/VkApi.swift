//
//  VkApi.swift
//  iosui
//
//  Created by vlad on 21.03.2021.
//

import Foundation
import RxSwift
import RxAlamofire

class VkApi : VkApiProtocol {
    
    private let session: UserSessionProtocol = UserSession.instance
    private let httpSession = URLSession(configuration: URLSessionConfiguration.default)

    func getUsersFor(userId: String?) -> Observable<Data> {
        let url = getUrl(method: .getUsers, userId: userId)

        return makeRequest(with: url, tag: "getUsersFor")
    }
    
    func getGroupsFor(userId: String?) -> Observable<Data> {
        let url = getUrl(method: .getGroups, userId: userId)
        
        return makeRequest(with: url, tag: "getGroupsFor")
    }
    
    func getPhotosFor(userId: String?) -> Observable<Data> {
        let url = getUrl(method: .getPhotos, userId: userId)
        
        return makeRequest(with: url, tag: "getPhotosFor")
    }
    
    func searchGroups(text: String) -> Observable<Data> {
        let url = getUrlWithParams(method: .searchGroups, userId: nil, params: text)
        
        return makeRequest(with: url, tag: "searchGroups")
    }
    
    private func log(tag: String, message: Any?) {
        print("\(tag): \(message ?? "")")
    }
    
    private func makeRequest(with urlS: String, tag: String) -> Observable<Data> {
        log(tag: tag, message: "request: \(urlS)")
        let encoded = urlS.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) ?? ""
        
        return RxAlamofire.requestData(.get, encoded)
            .map { response, data in
                let responseString = String(decoding: data, as: UTF8.self)
                self.log(tag: tag, message: "response: \(responseString)")
                
                return data
            }
    }
}

// MARK: -- SESSION

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
    
    func getUrl(method: VkRequests, userId: String?) -> String {
        let id = userId == nil ? session.getUserId() : userId!
        let token = session.getToken()
        let appId = session.getAppId()
        switch (method) {
        case .auth:
            return RequestFactory.getAuth(appId: appId)
        case .getGroups:
            return RequestFactory.getGroups(userId: id, token: token)
        case .getUsers:
            return RequestFactory.getUsers(userId: id, token: token)
        case .getPhotos:
            return RequestFactory.getPhotos(userId: id, token: token)
        default:
            return ""
        }
    }
    
    private func getUrlWithParams(method: VkRequests, userId: String?, params: String) -> String {
        let id = userId == nil ? session.getUserId() : userId!
        let token = session.getToken()
        let appId = session.getAppId()
        switch method {
        case .searchGroups:
            return RequestFactory.searchGroups(toSearch: params, token: token)
        default:
            return getUrl(method: method, userId: userId)
        }
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
//            "count=3&" +
            "access_token=\(token)&v=\(version)"
    }
    static func getUsers(userId: String, token: String) -> String {
        return baseUrl + "friends.get?" +
            "user_id=\(userId)&" +
            "order=name&" +
            "fields=photo_50,online,last_seen&" +
            "access_token=\(token)&v=\(version)"
    }
    static func getPhotos(userId: String, token: String) -> String {
        return baseUrl + "photos.get?" +
            "owner_id=\(userId)&" +
            "rev=1&" +
            "album_id=profile&" +
            "count=5&" +
            "&access_token=\(token)&v=\(version)"
        
    }
    
    // MARK: -- SEARCH
    static func searchGroups(toSearch: String, token: String) -> String {
        return baseUrl + "groups.search?" +
            "q=\(toSearch)&" +
            "type=group&" + 
            "count=100&" +
            "access_token=\(token)&v=\(version)"
    }
}

class ApiError : Error {
    private var errorType: Errors = .noData
    var localizedDescription: String {
        get {
            switch errorType {
            case .noData: return "response data is null"
            }
        }
    }
    
    init(type: Errors) {
        self.errorType = type
    }
    
    enum Errors {
        case noData
    }
}
