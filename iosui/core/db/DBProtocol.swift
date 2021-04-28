//
//  DBProtocol.swift
//  iosui
//
//  Created by Владислав Ершов on 01.04.2021.
//

import Foundation
import RealmSwift
import RxSwift

protocol TableProvider {
    associatedtype T : Object
    func getAll() -> Results<T>
    func insert(value: T)
    func insert(values: [T])
    func get(filter: String) -> Results<T>
    
    func clear()
}

enum DBTable {
    case users, group, photo
}
