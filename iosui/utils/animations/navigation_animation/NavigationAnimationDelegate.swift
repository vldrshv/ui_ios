//
//  NavigationAnimationDelegate.swift
//  iosui
//
//  Created by vlad on 26.02.2021.
//

import UIKit

class NavigationAnimationDelegate : UINavigationController, UINavigationControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .push {
            return NavigationAnimationPresent()
        } else if operation == .pop {
            return NavigationAnimationDismiss()
        }
        return nil
    }

}

