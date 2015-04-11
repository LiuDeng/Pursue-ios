//
//  UserInfoTableViewCell.swift
//  Pursue
//
//  Created by RAIN on 15/4/11.
//  Copyright (c) 2015年 Luce Studio. All rights reserved.
//

import UIKit

class ProfileUserInfoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var headImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = UIColor.clearColor()
        self.contentView.backgroundColor = UIColor.clearColor()
        
        RGCommonTools.customViewAddBorder(headImageView, width: 1.0, cornerRadius: headImageView.frame.size.width / 2, color: UIColor.clearColor())
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
