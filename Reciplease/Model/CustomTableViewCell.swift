//
//  CustomTableViewCell.swift
//  Reciplease
//
//  Created by françois demichelis on 12/03/2021.
//  Copyright © 2021 françois demichelis. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    static var identifier: String {
        return NSStringFromClass(self)
    }
    
    var customLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        customLabel = UILabel(frame: CGRect(x: 0, y: 0, width: contentView.frame.width, height: contentView.frame.height))
        customLabel.textAlignment = .center
        contentView.addSubview(customLabel)    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
