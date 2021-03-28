//
//  GroupsProvider.swift
//  iosui
//
//  Created by vlad on 07.02.2021.
//

import Foundation
import RxSwift

class GroupsProvider {
    
    private var groups = [IGroup]()
    private var userId: String? = nil
    
    private let api: IGroupsApi = VkApi()
    private let disposables = DisposeBag()
    
    func getData(userId: String?, onSuccess: (() -> Void)? = nil) {
        self.userId = userId
        mapToGroups(data: api.getGroupsFor(userId: userId))
            .observe(on: MainScheduler.instance)
            .subscribe (
                onNext: { isNotEmpty in
                    if isNotEmpty {
                        onSuccess?()
                    }
                    
                },
                onError: { error in print(error.localizedDescription) }
            )
            .disposed(by: disposables)
        
    }
    
    func searchGroups(text: String, onSuccess: (() -> Void)? = nil) {
        mapToGroups(data: text == "" ? api.getGroupsFor(userId: userId) : api.searchGroups(text: text))
            .observe(on: MainScheduler.instance)
            .subscribe (
                onNext: {
                    isNotEmpty in
                    if isNotEmpty {
                        onSuccess?()
                    }
                },
                onError: { error in print(error.localizedDescription) }
            )
            .disposed(by: disposables)
    }
    
    private func mapToGroups(data: Observable<Data>) -> Observable<Bool> {
        return data
            .map { data -> [VkGroupsResponse] in
                let response = JsonWrapper.getVkResponce(data: data) as VkResponse<VkGroupsResponse>
                return response.getResponseItems()
            }
            .map { items -> Bool in
                self.groups.removeAll()
                items.forEach { groupResponse in self.groups.append(VkGroup(groupResponse)) }
                return self.groups.count > 0
            }
    }
    
    func getGroups() -> [IGroup] {
        return groups//.filter { searchText == "" ? true : $0.getName().contains(searchText) }
    }
    
    func getGroupsCount() -> Int {
        return getGroups().count
    }
    
    func getGroup(at: IndexPath) -> IGroup {
        return getGroups()[at.item]
    }
}
