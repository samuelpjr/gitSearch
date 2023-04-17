//
//  UserWebViewController.swift
//  gitSearch
//
//  Created by Samuel Pinheiro Junior on 22/09/17.
//  Copyright © 2017 Samuel Pinheiro Junior. All rights reserved.
//

import UIKit
import WebKit

class UserWebViewController: UIViewController, AnimatableTabBarController {
    
    // MARK: - Properties
    lazy var webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    // MARK: - Public properties
    var urlUser: String
    
    // MARK: - Viewcontroller cicle
    init(urlUser: String) {
        self.urlUser = urlUser
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Controllers
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.startAnimating()
        setupViewController()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        spinner.stopAnimating()
        self.hideTabBarController()
    }
    
    // MARK: - Private Functions
    fileprivate func loadingUrlRequest() {
        if let userUrl = URL(string: urlUser){
            let userUrlRequest = URLRequest(url: userUrl)
            webView.load(userUrlRequest)
        }
    }
    
    private func setupViewController() {
        title = "User"
        view.addSubviews(webView, spinner)
        setupConstraints()
        spinner.startAnimating()
        loadingUrlRequest()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            webView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            webView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
