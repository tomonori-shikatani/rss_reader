//
//  ViewController.swift
//  rss_reader
//
//  Created by ShikataniTomonori on 2015/07/08.
//  Copyright (c) 2015年 ShikataniTomonori. All rights reserved.
//

import UIKit
import PageMenu

class ViewController: UIViewController {

    var pageMenu: CAPSPageMenu?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        var controllerArray: [UIViewController] = []
        var controller1 = self.storyboard?.instantiateViewControllerWithIdentifier("tableView") as! UIViewController
        controller1.title = "話題"
        controllerArray.append(controller1)

        var controller2 = self.storyboard?.instantiateViewControllerWithIdentifier("tableView") as! UIViewController
        controller2.title = "注目"
        controllerArray.append(controller2)
        
        var controller3 = self.storyboard?.instantiateViewControllerWithIdentifier("tableView") as! UIViewController
        controller3.title = "芸能"
        controllerArray.append(controller3)
        
        var controller4 = self.storyboard?.instantiateViewControllerWithIdentifier("tableView") as! UIViewController
        controller4.title = "ゲーム"
        controllerArray.append(controller4)
        
        var controller5 = self.storyboard?.instantiateViewControllerWithIdentifier("tableView") as! UIViewController
        controller5.title = "マンガ"
        controllerArray.append(controller5)
        
        var controller6 = self.storyboard?.instantiateViewControllerWithIdentifier("tableView") as! UIViewController
        controller6.title = "週刊誌"
        controllerArray.append(controller6)
        
        
        var parameters: [CAPSPageMenuOption] = [
            .MenuItemSeparatorWidth(4.3),
            .UseMenuLikeSegmentedControl(true),
            .MenuItemSeparatorPercentageHeight(0.1),
            .SelectionIndicatorColor(UIColor.cyanColor())
        ]
        
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRectMake(0.0, 20.0, self.view.frame.width, self.view.frame.height), pageMenuOptions: parameters)
        
        self.view.addSubview(pageMenu!.view)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
