//
//  LoaderView.swift
//  iosui
//
//  Created by vlad on 19.02.2021.
//

import UIKit

class LoaderView: BaseView {
    
    private let nibName = "UILoaderView"

    @IBOutlet var loaderContainer: UIStackView! {
        didSet {
            self.loadSubview(container: loaderContainer)//, isAutoresized: false)
        }
    }
    
    
    private var w: CGFloat = 0
    private var h: CGFloat = 0
    
    private var elementsCount = 0
    
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
        
        w = self.frame.size.width
        h = self.frame.size.height
    }
    
    func setLoaderItemsCount(count: Int, shapes: [Shape]) {
        var requireShapes = [Shape]()
        requireShapes.append(contentsOf: shapes)
        let minItems = 3
        let requireSize = max(count, minItems)
        
        
        if requireShapes.count < requireSize {
            for i in 0..<(requireSize - requireShapes.count) {
                requireShapes.append(.round)
            }
        }
        
        elementsCount = requireSize
        
        setupViews(requireShapes)
    }
    
    func animate(withType: AnimationType) {
        guard let subviews = loaderContainer.subviews as? [Animatable] else { return }
        for i in subviews.indices {
            guard let subview = subviews[i] as? LoaderItem else {
                continue
            }
            var nextView: Animatable
            if i < subviews.count - 1 {
                nextView = subviews[i + 1]
            } else {
                nextView = subviews[0]
            }
            
            let anim = AnimationUtil.getUnit(v: subview, duration: 0.5, nextView: nextView, type: .pulse)
            
            subview.saveAnimation(withUnit: anim)
        }
        if subviews.count > 0 {
            guard let startView = subviews[0] as? LoaderItem else { return }
            startView.animate()
        }
    }
    
    private func setupViews(_ shapes: [Shape]) {
        let itemWidth = w / CGFloat(elementsCount)
        for i in 0..<elementsCount {
            addViewToContainer(shapes[i], itemWidth, index: i)
        }
        self.bounds = CGRect(x: self.bounds.minX, y: self.bounds.minY, width: itemWidth * CGFloat(elementsCount), height: self.bounds.size.height)
    }
    
    private func addViewToContainer (_ shape: Shape, _ itemWidth: CGFloat, index: Int) {
        var container = LoaderItem(frame: CGRect(x: 0, y: 0, width: itemWidth, height: itemWidth))
        
        loaderContainer.insertArrangedSubview(container, at: index)
        container.layoutIfNeeded()
        container.setShape(shape: shape)
    }
}
