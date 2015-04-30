//
//  SearchViewController.swift
//  Pursue
//
//  Created by Johnson on 15/3/14.
//  Copyright (c) 2015年 Luce Studio. All rights reserved.
//

import UIKit


class SearchViewController: UIViewController {

    override func viewDidLoad()
    {
        super.viewDidLoad();

        var rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "pen"), style: UIBarButtonItemStyle.Done,target: self, action:"rightBarButtonPressed:");
        
        self.navigationItem.rightBarButtonItem = rightBarButtonItem;
        
        
        self.title = "寻人";
        
//        println("name = \(NSStringFromClass(AddSearchViewController))");

    }
    
    
    
    
    func rightBarButtonPressed(sender:AnyObject)
    {
        var addSearchVC = AddSearchViewController(nibName:"AddSearchViewController", bundle: nil);
        self.navigationController?.pushViewController(addSearchVC, animated: true);
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
