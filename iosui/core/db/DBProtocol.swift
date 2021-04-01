//
//  DBProtocol.swift
//  iosui
//
//  Created by Владислав Ершов on 01.04.2021.
//

import Foundation
import RealmSwift

protocol DBProtocol {
    func getProvider(type: DBTable) -> TableProvider
}

protocol TableProvider {
    func getAll() -> TableEntity?
    func insert(value: TableEntity)
    func insert(values: [TableEntity])
    func get() -> TableEntity?
}

class TableEntity : Object { }

enum DBTable {
    case users, group, photo
}
