//
//  RepoWebViewController.swift
//  gitSearch
//
//  Created by Samuel Pinheiro Junior on 22/09/17.
//  Copyright © 2017 Samuel Pinheiro Junior. All rights reserved.
//

import UIKit

class RepoWebViewController: UIViewController, AnimatableTabBarController {

    // MARK: - Outlets
    @IBOutlet weak var webView: UIWebView!
    
    // MARK: - Private properties
    private var activityIndicator = UIActivityIndicatorView()
    
    // MARK: - Public properties
    var urlRepo: String = ""
    
    // MARK: - Private Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        showActivitIndicator()
        if let repoUrl = URL(string: urlRepo){
            let repoUrlRequest = URLRequest(url: repoUrl)
            webView.loadRequest(repoUrlRequest)
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
