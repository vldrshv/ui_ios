//
//  JsonWrapper.swift
//  iosui
//
//  Created by Владислав Ершов on 27.03.2021.
//

import Foundation

class JsonWrapper {
    
    static func getVkResponce <T : Codable> (data: Data) -> VkResponse<T> {
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let response = try decoder.decode(VkResponse<T>.self, from: data)
            return response
        }
        catch {
            print("users decoding error")
            return VkResponse.empty()
        }
    }
}
