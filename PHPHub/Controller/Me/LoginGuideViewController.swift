//
//  LoginGuideViewController.swift
//  PHPHub
//
//  Created by 2014-104 on 15/12/23.
//  Copyright © 2015年 ninerec. All rights reserved.
//

import UIKit
import WebKit

class LoginGuideViewController: UIViewController {
    var webView: WKWebView?
    var guideUrl: String? {
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
        
        navigationItem.title = "登陆说明"
        loadURLContent()
    }
    
    fileprivate func loadURLContent() {
        if let stringURL = guideUrl, let webView = webView {
            let url = URL(string: stringURL)!
            webView.load(URLRequest(url: url))
            webView.allowsBackForwardNavigationGestures = true
        }
    }
}
