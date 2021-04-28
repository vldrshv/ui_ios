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

class TableProviderImpl<T : Object> : TableProvider {
    let realm = try! Realm()
    
    init() {
        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
    
    func getAll() -> Results<T> { //Observable<[T]> {
//        let realm = try! Realm()
        return realm.objects(T.self)
    }
    func get(filter: String?) -> Results<T> {
        if filter == nil {
            return getAll()
        }

        return realm.objects(T.self)
    }
    func insert(value: T) {
        do {
            realm.beginWrite()
            realm.add(value)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
    func insert(values: [T]) {
        do {
            realm.beginWrite()
            realm.add(values)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
    
    func clear() {
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
    }
}
