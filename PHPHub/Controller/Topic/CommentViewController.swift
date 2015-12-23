//
//  CommentViewController.swift
//  PHPHub
//
//  Created by 2014-104 on 15/12/23.
//  Copyright © 2015年 ninerec. All rights reserved.
//

import UIKit
import WebKit

class CommentViewController: UIViewController {
    var webView: WKWebView?
    var commentUrl: String? {
        didSet {
            loadURLContent()
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
        loadURLContent()
    }
    
    private func loadURLContent() {
        if let stringURL = commentUrl, let webView = webView {
            let url = NSURL(string: stringURL)!
            webView.loadRequest(NSURLRequest(URL: url))
            webView.allowsBackForwardNavigationGestures = true
        }
    }
}
