//
//  UserTableViewCell.swift
//  iosui
//
//  Created by vlad on 06.02.2021.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var lastOnlineDateLabel: UILabel!
    @IBOutlet weak var avatarContainer: AvatarView!
//    @IBOutlet weak var avatarView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addGestureRecognizer(tapGestureRecognizer)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUser(user: IUser) {
        self.nameLabel.text = user.getName()
        self.lastOnlineDateLabel.text = user.getLastOnlineDate()


        self.avatarContainer.setImage(path: user.getAvatarPath())
    }
    
    func makeRounded() {
        avatarContainer.setSize(self.avatarContainer.frame.width)
        avatarContainer.makeRounded()
        avatarContainer.setNeedsDisplay()
    }

    func addShadow() {
        avatarContainer.addShadow()
        avatarContainer.setNeedsDisplay()
    }
    
    // MARK: -- Actions

    lazy var tapGestureRecognizer: UITapGestureRecognizer = {
            let recognizer = UITapGestureRecognizer(target: self,
                                                    action: #selector(onTap))
            recognizer.numberOfTapsRequired = 1    // Количество нажатий, необходимое для распознавания
            recognizer.numberOfTouchesRequired = 1 // Количество пальцев, которые должны коснуться экрана для распознавания
            return recognizer
        }()


    @objc func onTap() {
        print("avatar")
        AnimationUtil.bouncing(unit: AnimationUnit(item: self.avatarContainer, duration: 0.5, nextItem: nil, animType: .bounce))
    }
    
}
