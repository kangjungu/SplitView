//
//  MasterViewController.swift
//  SplitView
//
//  Created by JHJG on 2016. 7. 13..
//  Copyright © 2016년 KangJungu. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    //웹사이트 이름과 주소를 저장할 배열 2개
    var siteNames:[String]?
    var siteAddresses:[String]?
    
    var detailViewController: DetailViewController? = nil
    var objects = [AnyObject]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        siteNames = ["Yahoo","Google","Apple","Bing"]
        siteAddresses = ["https://www.yahoo.com","https://www.google.com","https://www.apple.com","https://www.bing.com"]
        
        if let split = splitViewController{
            let controllers = split.viewControllers
            
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }

    }

    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func insertNewObject(sender: AnyObject) {
        objects.insert(NSDate(), atIndex: 0)
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }


    //segue로 정보 전달
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let urlString = siteAddresses?[indexPath.row]
                
                //DetailViewController 객체
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                //detailItem에 url을 설정
                controller.detailItem = urlString
                
                //바 버튼 아이템을 디테일 내비게이션 바에 추가. 이 버튼은 displayMode 버튼이다.
                //이버튼을 누르면 마트ㅓ 패널을 숨겨서 디테일 뷰를 전체화면으로 쓸수 있도록 사용자에게 제공된다.
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }


    //section 갯수
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    //테이블 아이템 갯수
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return siteNames!.count
    }

    //셀 초기화
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        cell.textLabel!.text = siteNames![indexPath.row]
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            objects.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }


}

