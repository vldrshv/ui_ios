//
//  VkResponse.swift
//  iosui
//
//  Created by Владислав Ершов on 27.03.2021.
//

import Foundation

struct VkResponse<T : Decodable> : Decodable {
    private let response: Response<T>?
    
    init() {
        self.response = nil
    }
    
    private struct Response<T : Decodable> : Decodable {
        let count: Int
        let items: [T]?
    }
    
    func getResponseItems() -> [T] {
        return response?.items ?? [T]()
    }
    
    static func empty() -> VkResponse<T> {
        return VkResponse<T>()
    }
}
