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
}
