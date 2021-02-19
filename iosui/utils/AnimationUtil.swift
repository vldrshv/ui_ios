//
//  AnimationUtil.swift
//  iosui
//
//  Created by vlad on 05.02.2021.
//

import Foundation
import UIKit

class AnimationUtil {
    
    static func scale(v: UIView, scaleTo: CGFloat = 0.8) {
        UIView.animate(withDuration: 0.1,
            animations: {
                v.transform = CGAffineTransform(scaleX: scaleTo, y: scaleTo)
            },
            completion: { _ in
                UIView.animate(withDuration: 0.6) {
                    v.transform = CGAffineTransform.identity
                }
            })
    }
    
    static func makeAnimationOf(unit: AnimationUnit) {
        UIView.animate(withDuration: unit.duration,
                       delay: 0,
                       options: [],
                       animations: {
                            if unit.animType == .pulse {
                                pulse(v: unit.item, to: 1)
                            }
                       },
                       completion: { _ in
                            unit.nextItem?.animate()
                            UIView.animate(withDuration: unit.duration) {
                                if unit.animType == .pulse {
                                    unit.item.alpha = 0
                                }
                            }
                        }
        )
    }
    
    static func bouncing(unit: AnimationUnit) {
        
        
        UIView.animate(withDuration: unit.duration,
                       delay: 0,
                       options: [],
                       animations: {
                            unit.item.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
                       },
                       completion: { _ in
                            UIView.animate(withDuration: 10,
                                           delay: 0,
                                           usingSpringWithDamping: 0.075,
                                           initialSpringVelocity: 1,
                                           options: [],
                                           animations: {
                                            unit.item.transform = CGAffineTransform.identity
                                           }
                            )
                        }
        )
        
        
    }
    
    static func getUnit(v: UIView, duration: TimeInterval, nextView: Animatable, type: AnimationType) -> AnimationUnit {
        return AnimationUnit(item: v, duration: duration, nextItem: nextView, animType: type)
    }
    
     private static func pulse(v: UIView, to: CGFloat) {
        v.alpha = to
    }
}

struct AnimationUnit {
    var item: UIView
    var duration: TimeInterval
    var nextItem: Animatable?
    var animType: AnimationType
}

protocol Animatable {
    func animate()
}
