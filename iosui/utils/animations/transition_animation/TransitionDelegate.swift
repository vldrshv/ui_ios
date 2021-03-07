//
//  TransitionDelegate.swift
//  iosui
//
//  Created by vlad on 26.02.2021.
//

import UIKit

class TransitionDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    private var view: UIView = UIView()

    func setFrame(_ frame: UIView) {
        self.view = frame
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return TransitionDismiss()
    }
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return TransitionPresent(view)
    }

}
