//
//  DBImpl.swift
//  iosui
//
//  Created by Владислав Ершов on 01.04.2021.
//

import Foundation
import RxSwift
import RxRealm
import RealmSwift

class DBImpl : DBProtocol {
    func getProvider(type: DBTable) -> TableProvider {
        switch type {
        case .group: return TableProviderImpl<VkGroupsResponse>()
        case .photo: return TableProviderImpl<VkPhotoResponse>()
        case .users: return TableProviderImpl<VkUserResponse>()
        }
    }
}

class TableProviderImpl<T : TableEntity> : TableProvider {
    func getAll() -> TableEntity? {
        return nil as T?
    }
    func get() -> TableEntity? {
        return nil
    }
    func insert(value: TableEntity) {
        let realm = try! Realm()
        var arr = [T]()
        arr.append(value as! T)
        Observable.from(arr)
            .subscribe(realm.rx.add())
    }
    func insert(values: [TableEntity]) {
        
    }
}

//class UsersTableProvider : TableProvider {
//    func getAll() -> TableEntity? {
//        return nil
//    }
//    func get() -> TableEntity? {
//        return nil
//    }
//    func insert(value: TableEntity) {
//
//    }
//    func insert(values: [TableEntity]) {
//
//    }
//}
//
//class PhotosTableProvider : TableProvider {
//    func getAll() -> TableEntity? {
//        return nil
//    }
//    func get() -> TableEntity? {
//        return nil
//    }
//    func insert(value: TableEntity) {
//
//    }
//    func insert(values: [TableEntity]) {
//
//    }
//}
//
//class GroupsTableProvider : TableProvider {
//    func getAll() -> TableEntity? {
//        return nil
//    }
//    func get() -> TableEntity? {
//        return nil
//    }
//    func insert(value: TableEntity) {
//
//    }
//    func insert(values: [TableEntity]) {
//
//    }
//
//}
