//
//  RGCommonTools.swift
//  RGCommonTools-Swift
//
//  Created by RAIN on 15/3/20.
//  Copyright (c) 2015年 Smartech Studio. All rights reserved.
//

import UIKit

class RGCommonTools: NSObject
{
    ///     为视图添加边线
    class func customViewAddBorder(view:UIView, width:CGFloat, cornerRadius:CGFloat, color:UIColor) {
        view.layer.masksToBounds = true
        view.layer.borderWidth = width
        view.layer.cornerRadius = cornerRadius
        view.layer.borderColor = color.CGColor
    }
    
}
