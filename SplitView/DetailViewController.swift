//
//  DetailViewController.swift
//  SplitView
//
//  Created by JHJG on 2016. 7. 13..
//  Copyright © 2016년 KangJungu. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var webView: UIWebView!

    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let detail:AnyObject = self.detailItem {
            
            //detailItem으로 웹페이지를 띄운다.
            if let myWebview = webView{
                let url = NSURL(string: detail as! String)
                let request = NSURLRequest(URL: url!)
                myWebview.scalesPageToFit = true
                myWebview.loadRequest(request)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

