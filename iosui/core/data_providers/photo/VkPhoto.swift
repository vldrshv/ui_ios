//
//  VkPhoto.swift
//  iosui
//
//  Created by Владислав Ершов on 28.03.2021.
//

import Foundation

class VkPhoto : IPhoto {
    private var photo: VkPhotoResponse?
    
    init(_ response: VkPhotoResponse) {
        self.photo = response
    }
    
    init(albumId: Int, date: CLong, id: Int = -1, ownerId: CLong = -1, sizes: [VkPhotoResponseSizes]) {
        self.photo = VkPhotoResponse()
        self.photo?.albumId = albumId
        self.photo?.date = date
        self.photo?.id = id
        self.photo?.ownerId = ownerId
        self.photo?.sizes = sizes
    }
    
    func getAlbumId() -> Int {
        return self.photo?.albumId ?? -1
    }
    func getDate() -> CLong {
        return self.photo?.date ?? 0
    }
    func getId() -> Int {
        return self.photo?.id ?? -1
    }
    func getPhotoUrlBy(type: VkPhotoType) -> String {
        let typeName = VkPhotoType.name(type: type)
        guard let sizes = self.photo?.sizes else { return "" }
        let res = sizes.filter { $0.type == typeName }
        return res.count == 0 ? "" : (res[0].url ?? "")
    }
    func getPhotoResponse() -> VkPhotoResponse? {
        return photo
    }
}

protocol IPhoto {
    func getAlbumId() -> Int
    func getDate() -> CLong
    func getId() -> Int
    func getPhotoUrlBy(type: VkPhotoType) -> String
    func getPhotoResponse() -> VkPhotoResponse?
}

enum VkPhotoType {
    case s, m, x, z
    // see VkPhotoResponse
    
    static func name(type: VkPhotoType) -> String {
        switch type {
        case .s: return "s"
        case .m: return "m"
        case .x: return "x"
        case .z: return "z"
        }
    }
}
