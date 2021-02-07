//
//  GroupsTableViewCell.swift
//  iosui
//
//  Created by vlad on 06.02.2021.
//

import UIKit

class GroupsTableViewCell: UITableViewCell {

    @IBOutlet weak var groupImage: UIImageView!
    @IBOutlet weak var groupNameLabel: UILabel!
    @IBOutlet weak var subcsribeButton: UIButton!
    
    private var onSibscribeListener: (() -> Void)? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setGroup(group: IGroup, onSibscribeClickedListener: @escaping () -> Void) {
        self.groupNameLabel.text = group.getName()
        self.groupImage.image = UIImage(named: group.getImagePath())
        
        self.onSibscribeListener = onSibscribeClickedListener
        var title = "subscribe"
        if group.isUserSubscribed() {
            title = "unsubscribe"
        }
        
        initButtonStyle(isActive: group.isUserSubscribed(), text: title)
    }
    
    @IBAction func onSubscribe(_ sender: Any) {
        guard let listener = onSibscribeListener else {
            return
        }
        
        AnimationUtil.scale(v: subcsribeButton, scaleTo: 0.95)
        listener()
    }
    
    func initButtonStyle(isActive: Bool, text: String) {
        subcsribeButton.setTitle(text, for: .normal)
        let layer = subcsribeButton.layer
        layer.borderWidth = 1
        layer.cornerRadius = 12
        
        if isActive {
            layer.backgroundColor = ColorUtils.white.cgColor
            subcsribeButton.setTitleColor(ColorUtils.black, for: .normal)
            layer.borderColor = ColorUtils.black.cgColor
        } else {
            layer.backgroundColor = ColorUtils.black.cgColor
            subcsribeButton.setTitleColor(ColorUtils.white, for: .normal)
            layer.borderColor = ColorUtils.white.cgColor
        }
    }
}
