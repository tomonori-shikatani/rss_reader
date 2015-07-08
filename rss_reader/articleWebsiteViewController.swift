//
//  articleWebsiteViewController.swift
//  rss_reader
//
//  Created by ShikataniTomonori on 2015/07/02.
//  Copyright (c) 2015年 ShikataniTomonori. All rights reserved.
//

import UIKit
import SVProgressHUD

class articleWebsiteViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var articleWebView: UIWebView!
    var articleURL:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let url = NSURL(string: articleURL)
        let request = NSURLRequest(URL: url!)
        self.articleWebView.loadRequest(request)
        articleWebView.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var i = 0
    
    func webViewDidStartLoad(webView: UIWebView) {
        if i == 0{
            SVProgressHUD.showWithStatus("読み込み中")
        }
        i++
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
            SVProgressHUD.dismiss()
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
