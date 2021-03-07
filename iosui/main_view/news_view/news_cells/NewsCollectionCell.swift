//
//  NewsCollectionCell.swift
//  iosui
//
//  Created by vlad on 17.02.2021.
//

import UIKit

class NewsCollectionCell: UICollectionViewCell {
    
//  MARK: -- VIEWS
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var newsTitle: UILabel!
    @IBOutlet private weak var newsLabel: UILabel!
    @IBOutlet private weak var newsImage: UIImageView!
    @IBOutlet private weak var likeButton: LikeButton!
    
//  MARK: -- CONSTRAINTS
    @IBOutlet private var maxWidthConstraint: NSLayoutConstraint! {
         didSet {
             maxWidthConstraint.isActive = false
         }
     }
    @IBOutlet private weak var titleWidthConstraint: NSLayoutConstraint!
    @IBOutlet private weak var textWidthConstraint: NSLayoutConstraint!
    @IBOutlet private weak var imageWidthConstraint: NSLayoutConstraint!
    @IBOutlet private weak var imageHeightConstraint: NSLayoutConstraint!
    
    private var maxWidth: CGFloat? = nil {
        didSet {
            guard let maxWidth = maxWidth else {
                return
            }
            maxWidthConstraint.isActive = true
            maxWidthConstraint.constant = maxWidth - 16
           
           textWidthConstraint.constant = maxWidthConstraint.constant - 32
            titleWidthConstraint.constant = textWidthConstraint.constant
           imageWidthConstraint.constant = maxWidthConstraint.constant
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.leftAnchor.constraint(equalTo: leftAnchor),
            contentView.rightAnchor.constraint(equalTo: rightAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        addShadows()

    }
    
    func setNews(title: String, text: String, imagePath: String) {
        newsTitle.text = title//"Pltcm fjdshgjs dfgds"
        newsLabel.text = text
        newsImage.image = UIImage(named: imagePath)
        
        newsImage.frame = updateImageSizes(newsImage.image)
        
        imageHeightConstraint.constant = newsImage.frame.height
        newsImage.setNeedsUpdateConstraints()
        newsImage.backgroundColor = .yellow
    }
    
    func setWidth(_ width: CGFloat) {
        self.maxWidth = width
    }
    
    func setLikes(isLiked: Bool, likesCount: Int) {
        likeButton.setLikes(isLiked: isLiked, likes: likesCount)
    }
    
    private func updateImageSizes(_ image: UIImage?) -> CGRect {
        guard let image = image else { return bounds }
        guard image.size.width > 0 && image.size.height > 0 else { return bounds }
        
        let scale = image.size.width / imageWidthConstraint.constant
        
        let size = CGSize(
            width: imageWidthConstraint.constant,
            height: image.size.height / scale
        )
        
        let x = (bounds.width - size.width) / 2.0
        let y = (bounds.height - size.height) / 2.0

        return CGRect(x: x, y: y, width: size.width, height: size.height)
    }
    
    
    private func addShadows() {
        containerView.clipsToBounds = false
        var layer = containerView.layer
        layer.masksToBounds = false
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = .zero
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 10
        layer.cornerRadius = 12
        
        //newsImage.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        newsImage.layer.cornerRadius = 12
    }
}
