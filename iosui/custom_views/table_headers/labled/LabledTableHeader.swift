//
//  LabledTableHeader.swift
//  iosui
//
//  Created by vlad on 13.02.2021.
//

import UIKit

class LabledTableHeader : UITableViewHeaderFooterView {
    
    @IBOutlet weak var headerContainer: UIView!
    @IBOutlet private weak var lableText: UILabel!
    
    func setText(text: String) {
        lableText.text = text
    }
    
    func setTintColor(color: UIColor?, alfa: Float = 1.0) {
        guard let nonNullColor = color else {
            return
        }
        headerContainer.backgroundColor = nonNullColor
        headerContainer.alpha = alpha
    }
    
    func setTextColor(color: UIColor) {
        lableText.textColor = color
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
