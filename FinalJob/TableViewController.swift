//
//  TableViewController.swift
//  NJU
//
//  Created by naive on 2019/12/23.
//  Copyright © 2019 linnaXie. All rights reserved.
//

import UIKit
import SwiftSoup

class TableViewController: UITableViewController,URLSessionDelegate {
    var dataTask: URLSessionDataTask?
    var errorMessage = ""
    var htmlFile:Document?
    var fourArea = [newArea]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fourArea.append(newArea(areaName: "人事通知"))
        fourArea.append(newArea(areaName: "人事新闻"))
        fourArea.append(newArea(areaName: "公示公告"))
        fourArea.append(newArea(areaName: "招聘信息"))
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        let delegate = self
        let session = URLSession(configuration: .default, delegate: delegate, delegateQueue:nil)

        dataTask = session.dataTask(with: URL(string: "http://hr.nju.edu.cn")!){
            [weak self] data, response, error in
            defer {
                self?.dataTask = nil
              }
              // 5
              if let error = error {
                self?.errorMessage += "DataTask error: " + error.localizedDescription + "\n"
              } else if let data = data,
                let htmlFileStr = String(data:data,encoding: String.Encoding.utf8){
                do {
                    self?.htmlFile = try SwiftSoup.parse(htmlFileStr)
                    self?.updataResults()
                }catch{
                    print("faild parsing!")
                }
                
            }
        }
            // 7
        dataTask?.resume()
        
    }
    
    private func updataResults(){
        
        print("开始解析")
        do{
            if let htmlFile = self.htmlFile{
                do{
                    let newsListElement = try htmlFile.getElementsByClass("news_list")
                    var sum = 0
                    for eachNewsList:Element in newsListElement.array(){
                        do{
                            let titleElements = try eachNewsList.getElementsByClass("news_title")
                            let dateElements = try eachNewsList.getElementsByClass("news_meta")
                            let hotElements = try eachNewsList.getElementsByClass("news_meta1")
                        
                            var allTitles = [String]()
                            var allDates = [String]()
                            var allHots = [String]()
                            var allURLs = [String]()
                            
                            for titleElement in titleElements{
                                let title = try titleElement.child(0).attr("title")
                                
                                let URL = try titleElement.child(0).attr("href")
                                allTitles.append(title)
                                allURLs.append(URL)
                            }
                            for dateElement in dateElements{
                                allDates.append(try dateElement.text())
                            }
                            for hotElement in hotElements{
                                allHots.append(try hotElement.text())
                            }
                            fourArea[sum].addChild(titles: allTitles, urls: allURLs, dates: allDates, hots: allHots)
                            sum = sum + 1
                            
                        }catch{
                            print("error")
                        }
                    }
                }catch{
                    print("error")
                }
            }
        }
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection
                                section: Int) -> String? {
        return fourArea[section].areaName
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return fourArea[section].numOfChild
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath)
        if let cell = cell as? TableViewCell{
            let cellNode = fourArea[indexPath.section].areaChild[indexPath.row]
            cell.title.text = cellNode.title
            cell.date.text = cellNode.date
            if cellNode.hot > 1000{
                cell.imageView?.isHidden = false
            }else{
                cell.imageView?.isHidden = true
            }
            cell.url = cellNode.previewURL
        }
         return cell
    }
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
          print("written \(bytesWritten) bytes")

      }
          
      func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
             print("finish")
        
         }
      
    
      
      func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didResumeAtOffset fileOffset: Int64, expectedTotalBytes: Int64) {
          print("resume at \(fileOffset)")
      }
    
    //goToMoreInfo
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToMoreInfo"{
            if let cell = sender as? TableViewCell, let controller = segue.destination as? ViewController{
                controller.nowURL = cell.url!
            }
        }
    }
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
