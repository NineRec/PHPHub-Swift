//
//  CommetViewController.swift
//  PHPHub
//
//  Created by 2014-104 on 15/12/23.
//  Copyright © 2015年 ninerec. All rights reserved.
//

import UIKit
import WebKit

class CommetViewController: UIViewController {
    var webView: WKWebView!
    var commetUrl = "" {
        didSet {
            let url = NSURL(string: commetUrl)!
            webView.loadRequest(NSURLRequest(URL: url))
            webView.allowsBackForwardNavigationGestures = true
        }
    }
    
    override func loadView() {
        super.loadView()
        
        webView = WKWebView()
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "评论列表"
    }
}
