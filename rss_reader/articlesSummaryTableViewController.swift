//
//  articlesSummaryTableViewController.swift
//  rss_reader
//
//  Created by ShikataniTomonori on 2015/07/02.
//  Copyright (c) 2015年 ShikataniTomonori. All rights reserved.
//

import UIKit

class articlesSummaryTableViewController: UITableViewController, MWFeedParserDelegate {
    
    let rssArray:[String] = [
    "http://news.livedoor.com/topics/rss.xml",
    "http://matome.naver.jp/feed/hot",
    "http://togetter.com/rss/index"
    ]
    var items = [MWFeedItem]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for mediaURL: String in rssArray{
            self.parseFeed(mediaURL)
        }

    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    func parseFeed(URL: String){
        
        var request:NSURL = NSURL(string: URL)!
        var feedParser = MWFeedParser(feedURL: request)
        feedParser.delegate = self
        feedParser.parse()

    }
    
    func feedParserDidStart(parser: MWFeedParser!) {
        
    }
        
    func feedParserDidFinish(parser: MWFeedParser!) {

    }

    
    func feedParser(parser: MWFeedParser!, didParseFeedInfo info: MWFeedInfo!) {

    }
    
    func feedParser(parser: MWFeedParser!, didParseFeedItem item: MWFeedItem!) {
        
        self.items.append(item)
        
    }
    
    func feedParser(parser: MWFeedParser!, didFailWithError error: NSError!) {
        println("MWFeedParser error:")
        println(error.localizedDescription)
    }
    
    

    

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.items.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 88
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("articleCell", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...
        let articleTitle = cell.viewWithTag(1) as! UILabel
        let articleURL   = cell.viewWithTag(2) as! UILabel
        let articleDate  = cell.viewWithTag(3) as! UILabel
        
        let item = self.items[indexPath.row] as MWFeedItem

        articleTitle.text = item.title
        articleURL.text   = item.link
        articleDate.text  = dateFormatter(item.date)
        
        return cell
    }

    // NSDate型からNSString型への変換メソッド
    func dateFormatter(date: NSDate) -> String{
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "ja-JP")
        dateFormatter.dateFormat = "M月d日HH時mm分"
        return dateFormatter.stringFromDate(date)
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if (segue.identifier == "toArticleWebsiteVC"){
        let nextVC = segue.destinationViewController as! articleWebsiteViewController
        let indexPath:NSIndexPath = self.tableView.indexPathForSelectedRow()!
        let item = self.items[indexPath.row]
        let articleURL = item.link
            nextVC.articleURL = articleURL
        }
    
    }
}
