//
//  RecordViewController.swift
//  Pursue
//
//  Created by 罗嗣宝 on 15/3/6.
//  Copyright (c) 2015年 Luce Studio. All rights reserved.
//

import Foundation

class RecordViewController: UIViewController {
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "随拍"
        
    }
    
}