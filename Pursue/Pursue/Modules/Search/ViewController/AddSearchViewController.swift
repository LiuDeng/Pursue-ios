//
//  AddSearchViewController.swift
//  Pursue
//
//  Created by Johnson on 15/3/14.
//  Copyright (c) 2015年 Luce Studio. All rights reserved.
//

import UIKit

class AddSearchViewController: UIViewController {
    
    @IBOutlet weak var describeTextView: UITextView!
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        buildUI()
    }
    
    private func buildUI() {
        self.title = "发布寻人"
        RGCommonTools.customViewAddBorder(describeTextView, width: 1, cornerRadius: 5, color: UIColor.blackColor())
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    
    
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
