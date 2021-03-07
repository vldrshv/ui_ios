//
//  GestureRecognizer.swift
//  iosui
//
//  Created by vlad on 07.03.2021.
//

import UIKit

class GestureRecognizer {
    
    private var listener: UserInteractionListener? = nil
    
    func setInteractionListener(listener: UserInteractionListener) {
        self.listener = listener
    }
    
    lazy var tapGestureRecognizer: UITapGestureRecognizer = {
            let recognizer = UITapGestureRecognizer(target: self,
                                                    action: #selector(onTap))
            recognizer.numberOfTapsRequired = 1    // Количество нажатий, необходимое для распознавания
            recognizer.numberOfTouchesRequired = 1 // Количество пальцев, которые должны коснуться экрана для распознавания
            return recognizer
        }()

    
    @objc func onTap() {
        listener?.onTapRegistered()
    }
}
