//
//  BaseView.swift
//  iosui
//
//  Created by vlad on 19.02.2021.
//

import UIKit

class BaseView: UIView {
    
//    var nibName: String? = nil {
//        didSet {
//            loadView()
//        }
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    internal func loadView(nibName: String) {
        let nib = UINib(nibName: nibName, bundle: .main)
        nib.instantiate(withOwner: self, options: nil)
    }
    
    internal func loadSubview(container: UIView, isAutoresized: Bool = true) {
        // next: append the container to our view
        self.addSubview(container)
        container.frame = self.bounds
        if isAutoresized {
            container.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        }
        container.layoutIfNeeded()
    }

}
