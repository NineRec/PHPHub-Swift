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

        // circle the avatar
        avatarImageView.layer.cornerRadius = avatarImageView.frame.height / 2
        avatarImageView.clipsToBounds = true
        
        updateTopicDetail()

        // observe the web loading
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .New, context: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = contentView.bounds
    }
    
    private func updateTopicDetail() {
        if let topic = topic {
            let user = topic.user
            avatarImageView.kf_setImageWithURL(NSURL(string: user.avatar)!, placeholderImage: UIImage(named: "avatar_placeholder"))
            usernameLabel.text = user.username
            signatureLabel.text = user.signature
            
            voteButton.setTitle(" \(topic.voteCount)", forState: .Normal)
            
            let url = NSURL(string: topic.topicContentUrl)!
            webView.loadRequest(NSURLRequest(URL: url))
            webView.allowsBackForwardNavigationGestures = true
            
            commentButton.setTitle(" \(topic.topicRepliesCount)", forState: .Normal)
        }
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if let keyPath = keyPath {
            switch keyPath {
            case "estimatedProgress":
                progressView.hidden = webView.estimatedProgress == 1
                progressView.setProgress(Float(webView.estimatedProgress), animated: true)
            default:
                break
            }
        }
    }
    
    @IBAction func didTouchCommentButton() {
        if let topic = topic {
            let commentVC = CommentViewController()
            commentVC.commentUrl = topic.topicRepliesUrl
            navigationController?.pushViewController(commentVC, animated: true)
        }
    }
}

extension TopicDetailViewController: WKNavigationDelegate {
    func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
        progressView.setProgress(0.0, animated: false)
    }
}
