//
//  UINavigationUtils.swift
//  iosui
//
//  Created by vlad on 06.02.2021.
//

import Foundation
import UIKit

class UINavigationUtils {
    
    static func manageNavigationVisibility(navController: UINavigationController, appBarHidden: Bool = true, bottomBarHidden: Bool = true) {
        navController.navigationBar.isHidden = bottomBarHidden
        navController.tabBarController?.tabBar.isHidden = appBarHidden
    }
}
