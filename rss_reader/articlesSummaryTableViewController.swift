//
//  articlesSummaryTableViewController.swift
//  rss_reader
//
//  Created by ShikataniTomonori on 2015/07/02.
//  Copyright (c) 2015年 ShikataniTomonori. All rights reserved.
//

import UIKit
import MWFeedParser

class articlesSummaryTableViewController: UITableViewController, MWFeedParserDelegate {
    
    let rssArray1:[String] = [
        "http://news.livedoor.com/topics/rss.xml",
        "http://feeds.feedburner.com/hatena/b/hotentry",
        "http://news.nicovideo.jp/ranking/comment/?rss=2.0",
        "http://togetter.com/rss/index",
        "http://matome.naver.jp/feed/hot"
    ]
    
    
    let rssArray2:[String] = [
        "http://alfalfalfa.com/index.rdf",
        "http://blog.livedoor.jp/kinisoku/index.rdf",
        "http://blog.livedoor.jp/chihhylove/index.rdf",
        "http://jin115.com/index.rdf",
        "http://blog.esuteru.com/index.rdf"
    ]
    
    
    let rssArray3:[String] = [
        "http://japan.techinsight.jp/index.xml",
        "http://natalie.mu/owarai/feed/news",
        "http://news.livedoor.com/topics/rss/ent.xml",
        "http://blog.livedoor.jp/sky_wing2010-geinou/index.rdf",
        "http://gossip1.net/index.rdf"

    ]
    
    let rssArray4:[String] = [
        "http://www.famitsu.com/rss/fcom_all.rdf",
        "http://gamebiz.jp/?feed=rss",
        "http://dengekionline.com/cate/11/rss.xml",
        "http://www.4gamer.net/rss/index.xml",
        "http://www.gamespark.jp/rss/index.rdf"

    ]
    
    
    let rssArray5:[String] = [
        "http://yaraon-blog.com/feed",
        "http://kai-you.net/contents/feed.rss",
        "http://natalie.mu/comic/feed/news",
        "http://animeanime.jp/rss/index.rdf",
        "https://akiba-souken.com/feed/all/"

    ]
    
    let rssArray6:[String] = [
        "http://feed.rssad.jp/rss/spa/feed",
        "http://wpb.shueisha.co.jp/feed/",
        "http://rss.rssad.jp/rss/cyzo/atom.xml"
    ]
    

    var items = [MWFeedItem]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //プル&リリースで更新（https://github.com/dekatotoro/PullToRefreshSwift）
        self.tableView.addPullToRefresh({ [weak self] in
            // refresh code
            
            self?.tableView.reloadData()
            self?.tableView.stopPullToRefresh()
            })
        
        //各RSSフィードごとにparserを呼び出し
        if (self.title == "話題"){
            for mediaURL: String in rssArray1{
                self.parseFeed(mediaURL)
            }
        }
        else if(self.title == "注目"){
            for mediaURL: String in rssArray2{
                self.parseFeed(mediaURL)
            }
        }
        else if(self.title == "芸能"){
            for mediaURL: String in rssArray3{
                self.parseFeed(mediaURL)
            }
        }
        else if(self.title == "ゲーム"){
            for mediaURL: String in rssArray4{
                self.parseFeed(mediaURL)
            }
        }
        else if(self.title == "マンガ"){
            for mediaURL: String in rssArray5{
                self.parseFeed(mediaURL)
            }
        }
        else{
            for mediaURL: String in rssArray6{
                self.parseFeed(mediaURL)
            }
        }
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    func parseFeed(URL: String){
        //パースの開始
        var request:NSURL = NSURL(string: URL)!
        var feedParser = MWFeedParser(feedURL: request)
        feedParser.delegate = self
        feedParser.parse()

    }
    
    func feedParserDidStart(parser: MWFeedParser!) {
        
    }
        
    func feedParserDidFinish(parser: MWFeedParser!) {
        //パースしたitemを投稿日時順にソート（降順）
        items.sort { (article1, article2) -> Bool in
            let cmp = article1.date.compare(article2.date)
            if cmp == NSComparisonResult.OrderedDescending {return true}
            return false
        }

    }

    
    func feedParser(parser: MWFeedParser!, didParseFeedInfo info: MWFeedInfo!) {

    }
    
    func feedParser(parser: MWFeedParser!, didParseFeedItem item: MWFeedItem!) {
        //リストは最大50記事
        if (self.items.count < 50){
        self.items.append(item)
        }
    }
    
    func feedParser(parser: MWFeedParser!, didFailWithError error: NSError!) {
        //パースエラー時にエラー内容を表示
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
        
        //記事タイトル40文字以上以降切り捨て
        if (count(item.title) > 40){
            let tmpTitle = item.title
            let itemTitleTrunscate = tmpTitle.substringToIndex(advance(tmpTitle.startIndex, 40))
            let tailString = "..."
            articleTitle.text = itemTitleTrunscate + tailString
        }
        else
        {
            articleTitle.text = item.title
        }
        
        //記事URL
        if (count(item.link) > 30){
            let tmpLink = item.link
            let itemLinkTrunscate = tmpLink.substringToIndex(advance(tmpLink.startIndex, 30))
            let tailString = "..."
            articleURL.text = itemLinkTrunscate + tailString
        }
        else
        {
            articleURL.text = item.link
        }
        
        //記事投稿日
        articleDate.text  = dateFormatter(item.date)
        
        return cell
    }

    // item投稿日時をNSDate型からNSString型へ変換
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
