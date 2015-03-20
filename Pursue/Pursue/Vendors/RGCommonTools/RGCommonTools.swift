//
//  RGCommonTools.swift
//  Pursue
//
//  Created by RAIN on 15/3/20.
//  Copyright (c) 2015年 Luce Studio. All rights reserved.
//

import UIKit

class RGCommonTools: NSObject
{
    class func customViewAddBorder(view:UIView, width:CGFloat, cornerRadius:CGFloat, color:UIColor) {
        view.layer.masksToBounds = true
        view.layer.borderWidth = width
        view.layer.cornerRadius = cornerRadius
        view.layer.borderColor = color.CGColor
    }
    
}
