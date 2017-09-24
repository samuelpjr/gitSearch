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
    
    // MARK: - Private properties
    private var activityIndicator = UIActivityIndicatorView()
    
    // MARK: - Public properties
    var urlUser: String = ""
    
    // MARK: - Controllers
    override func viewDidLoad() {
        super.viewDidLoad()
        showActivitIndicator()
        if let userUrl = URL(string: urlUser){
            let userUrlRequest = URLRequest(url: userUrl)
            webView.loadRequest(userUrlRequest)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.activityIndicator.stopAnimating()
        self.hide()
    }
    
    // MARK: - Private Functions
    private func showActivitIndicator(){
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
}
