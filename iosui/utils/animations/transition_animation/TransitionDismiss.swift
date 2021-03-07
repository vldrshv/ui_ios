//
//  TransitionDismiss.swift
//  iosui
//
//  Created by vlad on 26.02.2021.
//

import UIKit

class TransitionDismiss : NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let source = transitionContext.viewController(forKey: .from)
        else { return }
        guard let destination = transitionContext.viewController(forKey: .to)
        else { return }
        
        let containerViewFrame = transitionContext.containerView.frame
        let sourceViewTargetFrame = CGRect(x: 0,
                                           y: containerViewFrame.height,
                                           width: source.view.frame.width,
                                           height: source.view.frame.height)
        
        let destinationViewTargetFrame = source.view.frame

        transitionContext.containerView.addSubview(source.view)

        destination.view.frame = CGRect(x: 0,
                                        y: -containerViewFrame.height,
                                        width: source.view.frame.width,
                                        height: source.view.frame.height)

        UIView
            .animate(withDuration: self.transitionDuration(using: transitionContext),
                     animations: {
                        source.view.frame = sourceViewTargetFrame
                        destination.view.frame = destinationViewTargetFrame
        }) { finished in
            source.removeFromParent()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
    
    func animationEnded(_ transitionCompleted: Bool) {
        
    }
}

