//
//  SingleNewsViewController.swift
//  iosui
//
//  Created by vlad on 07.03.2021.
//

import UIKit

class SingleNewsViewController: UIViewController {
    
    var imagePath: String = ""
    var newsTitleText: String = ""
    var newsBodyText: String = ""
    
    @IBOutlet private weak var newsImage: UIImageView!
    @IBOutlet private weak var newsTitle: UILabel!
    @IBOutlet private weak var newsText: UILabel!
    
    @IBOutlet private weak var imageWidth: NSLayoutConstraint!
    @IBOutlet private weak var imageHeight: NSLayoutConstraint!
    
    @IBAction func closeVC(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        newsImage.image = UIImage(named: imagePath)
        updateImageSizes(newsImage)
        newsTitle.text = newsTitleText
        newsText.text = newsBodyText

    }
    
    private func updateImageSizes(_ imageView: UIImageView) {
        guard let image = imageView.image else { return }
        guard image.size.width > 0 && image.size.height > 0 else { return }
        
        let scale = image.size.width / imageWidth.constant
        
        let screen = UIScreen.main.bounds
        imageWidth.constant = screen.width
        imageWidth.isActive = true
        
        imageHeight.constant = image.size.height / scale
        imageHeight.isActive = true
    }


}
