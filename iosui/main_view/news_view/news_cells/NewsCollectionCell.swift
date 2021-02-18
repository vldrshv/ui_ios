//
//  NewsCollectionCell.swift
//  iosui
//
//  Created by vlad on 17.02.2021.
//

import UIKit

class NewsCollectionCell: UICollectionViewCell {
    
    
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var newsLabel: UILabel!
    @IBOutlet private weak var newsImage: UIImageView!
    
    @IBOutlet private var maxWidthConstraint: NSLayoutConstraint! {
         didSet {
             maxWidthConstraint.isActive = false
         }
     }

     private var maxWidth: CGFloat? = nil {
         didSet {
             guard let maxWidth = maxWidth else {
                 return
             }
             maxWidthConstraint.isActive = true
             maxWidthConstraint.constant = maxWidth - 16
            
            textWidthConstraint.constant = maxWidthConstraint.constant - 32
            imageWidthConstraint.constant = maxWidthConstraint.constant
         }
     }

    @IBOutlet private weak var textWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet private weak var imageWidthConstraint: NSLayoutConstraint!
    @IBOutlet private weak var imageHeightConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .green

        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.leftAnchor.constraint(equalTo: leftAnchor),
            contentView.rightAnchor.constraint(equalTo: rightAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

    }
    
    func setNews(title: String, imagePath: String) {
        newsLabel.text = title
        newsImage.image = UIImage(named: imagePath)
        
        newsImage.frame = updateImageSizes(newsImage.image)
//        imageHeightConstraint.constant = newsImage.frame.height
        newsImage.backgroundColor = .yellow
    }
    
    func setWidth(_ width: CGFloat) {
        self.maxWidth = width
    }
    
    
    private func updateImageSizes(_ image: UIImage?) -> CGRect {
        guard let image = image else { return bounds }
//        guard contentMode == .scaleAspectFit else { return bounds }
        guard image.size.width > 0 && image.size.height > 0 else { return bounds }

        let scale = image.size.width / image.size.height
        
        let size = CGSize(
            width: newsImage.frame.size.width,
            height: newsImage.frame.size.width * scale
        )
        
        let x = (bounds.width - size.width) / 2.0
        let y = (bounds.height - size.height) / 2.0

        return CGRect(x: x, y: y, width: size.width, height: size.height)
    }
    
}
