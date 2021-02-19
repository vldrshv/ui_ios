//
//  LoaderItem.swift
//  iosui
//
//  Created by vlad on 19.02.2021.
//

import UIKit

class LoaderItem : BaseView, Animatable {
    
    private let nibName = "UILoaderItem"
    
    @IBOutlet var itemContainer: UIView! {
        didSet {
            self.loadSubview(container: itemContainer)
        }
    }
    @IBOutlet weak var itemView: UIView!
    
    private var animation: AnimationUnit? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadView(nibName: nibName)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.loadView(nibName: nibName)
    }
    
    override func loadView(nibName: String) {
        super.loadView(nibName: nibName)
        self.itemView.layer.backgroundColor = UIColor.red.cgColor
    }
    
    func setShape(shape: Shape) {
        if shape == .round {
            itemView.layer.cornerRadius = itemView.frame.size.width / 2
            print(itemView.layer.cornerRadius)
        }
    }
    
    func saveAnimation(withUnit: AnimationUnit) {
        animation = withUnit
    }
    
    func animate() {
        guard let animation = animation else { return }
        AnimationUtil.makeAnimationOf(unit: animation)
    }

}
