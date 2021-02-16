//
//  ShareButton.swift
//  iosui
//
//  Created by vlad on 16.02.2021.
//

import UIKit

class ShareButton : ActionButton, UserInteractionListener {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setInteractionListener(listener: self)
        
        initImage()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setInteractionListener(listener: self)
        
        initImage()
        initText()
    }
    
    private func initImage() {
        if #available(iOS 13.0, *) {
            imageSource = UIImage(systemName: "square.and.arrow.up")
        } else {
            // Fallback on earlier versions
        }
    }
    
    func onTapRegistered() {
        AnimationUtil.scale(v: self.actionImage, scaleTo: 0.95)
    }
    
    private func initText() {
        actionLabelText = "10"
    }
    
}
