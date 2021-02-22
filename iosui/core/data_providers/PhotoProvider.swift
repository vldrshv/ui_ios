//
//  PhotoProvider.swift
//  iosui
//
//  Created by vlad on 22.02.2021.
//

import Foundation

class PhotoProvider {
        
    static func getPhotoPaths(photoCount: Int) -> [String] {
        var photoSet = [String]()
        
        while photoSet.count != photoCount {
            let photoNum = Int.random(in: 1...photoCount)
            let photoName = "photo_\(photoNum)"
            
            if !photoSet.contains(photoName) {
                photoSet.append(photoName)
            }
        }
        
        return photoSet
    }
}
