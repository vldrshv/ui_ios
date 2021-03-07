//
//  TransitionPresent.swift
//  iosui
//
//  Created by vlad on 26.02.2021.
//

import UIKit

class TransitionPresent : NSObject, UIViewControllerAnimatedTransitioning {
    
    private var v = UIView()

    init(_ frame: UIView) {
        self.v = frame
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let source = transitionContext.viewController(forKey: .from)
        else { return }
        guard let destination = transitionContext.viewController(forKey: .to)
        else { return }
                
        let destinationViewTargetFrame = source.view.frame

        transitionContext.containerView.addSubview(destination.view)

        destination.view.frame = CGRect(x: 0,
                                        y: 0,
                                        width: destinationViewTargetFrame.width,
                                        height: destinationViewTargetFrame.height)
        destination.view.alpha = 0
        

        UIView.animate(withDuration: self.transitionDuration(using: transitionContext),
                animations: {
                    let viewCenterX = self.v.frame.origin.x + self.v.frame.width / 2
                    let viewCenterY = self.v.frame.origin.y + self.v.frame.height / 2
                    
                    print("view center = \(viewCenterX), \(viewCenterY)")
                    
                    let destCenterX = destinationViewTargetFrame.origin.x + destinationViewTargetFrame.width / 2
                    let destCenterY = destinationViewTargetFrame.origin.y + destinationViewTargetFrame.height / 2
                    
                    print("dest center = \(destCenterX), \(destCenterY)")
                        
                    let toX = (destCenterX - viewCenterX) / 2
                    print(toX)
                    let toY = (destCenterY - viewCenterY) / 2
                    print(toY)
                        
                    self.v.transform = CGAffineTransform(
                        scaleX: 2,
                        y: 2
                    ).translatedBy(x: toX, y: toY)
                    self.v.layer.zPosition = 10
                    destination.view.alpha = 0.7
                        
        }) { finished in
            destination.view.frame = destinationViewTargetFrame
            self.v.layer.zPosition = 0
            destination.view.alpha = 1
            self.v.transform = .identity
            source.removeFromParent()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }

    func animationEnded(_ transitionCompleted: Bool) {
        
    }
}
