//
//  RepoWebViewController.swift
//  gitSearch
//
//  Created by Samuel Pinheiro Junior on 22/09/17.
//  Copyright © 2017 Samuel Pinheiro Junior. All rights reserved.
//

import UIKit
import WebKit

class RepoWebViewController: UIViewController, AnimatableTabBarController {

    // MARK: - Outlets
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Public properties
    var urlRepo: String = ""
    
    // MARK: - Controllers
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        loadingUrlRequest()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        activityIndicator.stopAnimating()
        self.hideTabBarController()
    }
    
    // MARK: - Private Functions
    fileprivate func loadingUrlRequest() {
        if let repoUrl = URL(string: urlRepo){
            let repoUrlRequest = URLRequest(url: repoUrl)
            webView.load(repoUrlRequest)
        }
    }
    
}
