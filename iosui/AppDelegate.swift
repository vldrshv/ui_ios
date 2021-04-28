//
//  AppDelegate.swift
//  iosui
//
//  Created by vlad on 30.01.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    private static var photoDbProvider: TableProviderImpl<VkPhotoResponse>?

    
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        return true
    }
}

extension AppDelegate {
    static func getPhotoDBProvider() -> TableProviderImpl<VkPhotoResponse> {
        if photoDbProvider == nil {
            photoDbProvider = TableProviderImpl<VkPhotoResponse>()
            photoDbProvider!.clear()
        }
        
        return photoDbProvider!
    }
}

