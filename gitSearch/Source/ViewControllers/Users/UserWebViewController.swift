//
//  UserWebViewController.swift
//  gitSearch
//
//  Created by Samuel Pinheiro Junior on 22/09/17.
//  Copyright © 2017 Samuel Pinheiro Junior. All rights reserved.
//

import UIKit

class UserWebViewController: UIViewController, AnimatableTabBarController {
    
    // MARK: - Outlets
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Public properties
    var urlUser: String = ""
    
    // MARK: - Controllers
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        loadingUrlRequest()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        activityIndicator.stopAnimating()
        self.hide()
    }
    
    // MARK: - Private Functions
    fileprivate func loadingUrlRequest() {
        if let userUrl = URL(string: urlUser){
            let userUrlRequest = URLRequest(url: userUrl)
            webView.loadRequest(userUrlRequest)
        }
    }
}
