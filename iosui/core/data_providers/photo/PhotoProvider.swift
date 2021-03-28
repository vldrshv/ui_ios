//
//  PhotoProvider.swift
//  iosui
//
//  Created by vlad on 22.02.2021.
//

import Foundation
import RxSwift

class PhotoProvider {
    
    private let disposables = DisposeBag()
    private let api: IPhotoApi = VkApi()
    private var photos = [IPhoto]()
        
    func getData(userId: String?, onSuccess: (() -> Void)? = nil) {
        api.getPhotosFor(userId: userId)
            .observe(on: MainScheduler.instance)
            .map { data -> [VkPhotoResponse] in
                let response = JsonWrapper.getVkResponce(data: data) as VkResponse<VkPhotoResponse>
                return response.getResponseItems()
            }
            .map { items -> Bool in
                self.photos.removeAll()
                items.forEach { photoResponse in self.photos.append(VkPhoto(photoResponse)) }
                
                return self.photos.count > 0
            }
            .subscribe(
                onNext: { isNotEmpty in
                    if isNotEmpty {
                        onSuccess?()
                    }
                },
                onError: { error in print(error.localizedDescription) }
            )
            .disposed(by: disposables)
        
    }
    
    func getPhotoCount() -> Int {
        return photos.count
    }
    
    func getPhotoPathAt(index: IndexPath) -> String {
        return getMedium(index: index)
    }
    
    func getSmall(index: IndexPath) -> String {
        return photos[index.item].getPhotoUrlBy(type: .s)
    }
    func getMedium(index: IndexPath) -> String {
        return photos[index.item].getPhotoUrlBy(type: .m)
    }
    func getLarge(index: IndexPath) -> String {
        return photos[index.item].getPhotoUrlBy(type: .x)
    }
    func getHD(index: IndexPath) -> String {
        return photos[index.item].getPhotoUrlBy(type: .z)
    }
}
