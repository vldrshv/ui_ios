//
//  PhotoTableViewCell.swift
//  iosui
//
//  Created by vlad on 16.02.2021.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var newsText: UILabel!
    @IBOutlet weak var likeButton: LikeButton!
    @IBOutlet weak var newsImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setNewsText(text: String) {
        newsText.text = text
    }
    func setLikes(isLiked: Bool, likes: Int) {
        likeButton.setLikes(isLiked: isLiked, likes: likes)
    }
    func setImagePath(path: String) {
        guard let image = UIImage(named: path) else { return }
        
        resizeImage(image)
        newsImage.image = image
//        newsImage.image = image
        
    }
    
    // вот просто не понимаю.
    // приходит картинка w/h = 2/1
    // контейнер w/h = 400/x
    // то есть
    //  2     400
    //  -  =  ---
    //  1      х
    
    private func resizeImage(_ image: UIImage) {
        print("resize image")

        let newHeight = newsImage.frame.height * (image.size.height / image.size.width)

        newsImage.frame.size = CGSize(
            width: newsImage.frame.width,
            height: newHeight
        )
        newsImage.setNeedsDisplay()
        newsImage.backgroundColor = .yellow

    }
    
    private func manageImageSize(_ image: UIImage) {
        
    }
}
