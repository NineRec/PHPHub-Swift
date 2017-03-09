//
//  TopicDetailViewController.swift
//  PHPHub
//
//  Created by 2014-104 on 15/12/18.
//  Copyright © 2015年 ninerec. All rights reserved.
//

import UIKit
import WebKit
import Kingfisher

class TopicDetailViewController: UIViewController {
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var signatureLabel: UILabel!
    @IBOutlet weak var voteButton: UIButton!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var authorInfoView: UIView!
    
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBOutlet weak var topicToolBarView: UIView!
    @IBOutlet weak var commentButton: UIButton!
    
    var webView: WKWebView!
    var topic: Topic?
    
    deinit {
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView = WKWebView(frame: contentView.bounds)
        contentView.addSubview(webView)
        // observe the web loading
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)

        // circle the avatar
        avatarImageView.layer.cornerRadius = avatarImageView.frame.height / 2
        avatarImageView.clipsToBounds = true
        
        updateTopicDetail()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = contentView.bounds
    }
    
    fileprivate func updateTopicDetail() {
        if let topic = topic {
            let user = topic.user
            avatarImageView.kf_setImageWithURL(URL(string: user.avatar)!, placeholderImage: UIImage(named: "avatar_placeholder"))
            usernameLabel.text = user.username
            signatureLabel.text = user.signature
            
            voteButton.setTitle(" \(topic.voteCount)", for: UIControlState())

            let request = Router.topicDetails(topic.topicId).URLRequest
            webView.load(request)
            webView.allowsBackForwardNavigationGestures = true
            
            commentButton.setTitle(" \(topic.topicRepliesCount)", for: UIControlState())
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let keyPath = keyPath {
            switch keyPath {
            case "estimatedProgress":
                progressView.setProgress(Float(webView.estimatedProgress), animated: true)
                if webView.estimatedProgress == 1 {
                    progressView.isHidden = true
                    let jsString = "var metaTag=document.createElement('meta');" +
                        "metaTag.name='viewport';metaTag.content ='width=device-width,initial-scale=1.0';" +
                        "document.getElementsByTagName('head')[0].appendChild(metaTag);"
                    webView.evaluateJavaScript(jsString, completionHandler: nil)
                }
            case "title":
                if let title = webView.title {
                    self.title = title
                }
            default:
                break
            }
        }
    }
    
    @IBAction func didTouchCommentButton() {
        if let topic = topic {
            let commentVC = CommentViewController()
            commentVC.topic = topic
            navigationController?.pushViewController(commentVC, animated: true)
        }
    }
}

extension TopicDetailViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        progressView.setProgress(0.0, animated: false)
    }
}
