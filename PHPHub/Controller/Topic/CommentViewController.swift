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
    var topic: Topic?
    
    override func loadView() {
        super.loadView()
        
        webView = WKWebView()
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "评论列表"
        
        if let topic = topic, let webView = webView {
            let request = Router.TopicReplies(topic.topicId).getURLRequest()
            webView.loadRequest(request)
            webView.allowsBackForwardNavigationGestures = true
        }
    }
}
