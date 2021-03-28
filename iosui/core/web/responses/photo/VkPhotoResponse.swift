//
//  VkPhotoResponse.swift
//  iosui
//
//  Created by Владислав Ершов on 28.03.2021.
//

import Foundation

struct VkPhotoResponse : Codable {
    let albumId: Int?
    let date: CLong?
    let id: Int?
    let sizes: [VkPhotoResponseSizes]?
}

struct VkPhotoResponseSizes : Codable {
    let height: Int?
    let url: String?
    let type: String?
    let width: Int?
}

//{
//    "album_id": -6,
//    "date": 1538070302,
//    "id": 456243950,
//    "owner_id": 54480548,
//    "has_tags": false,
//    "post_id": 2748,
//    "sizes": [
//        {
//        "height": 130,
//        "url": "https://sun9-33.u...2qKU&type=album",
//        "type": "m",
//        "width": 130
//        },
//        ...
//        {}
//    ]
//}


// types:
//s — пропорциональная копия изображения с максимальной стороной 75px;
//m — пропорциональная копия изображения с максимальной стороной 130px;
//x — пропорциональная копия изображения с максимальной стороной 604px;
//y — пропорциональная копия изображения с максимальной стороной 807px;
//z — пропорциональная копия изображения с максимальным размером 1080x1024;
//w — пропорциональная копия изображения с максимальным размером 2560x2048px.
