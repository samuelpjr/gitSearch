//
//  UsersTableviewController.swift
//  gitSearch
//
//  Created by Samuel Pinheiro Junior on 21/09/17.
//  Copyright © 2017 Samuel Pinheiro Junior. All rights reserved.
//

import UIKit

class UsersTableviewController: UIViewController, AnimatableTabBarController {
    
    // MARK: - Private properties
    private var viewModel: UsersViewModel?
    private var language: String = ""
    private var urlWebview: String?
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Public properties
    var languageTxt: String = ""
   
    
    // MARK: ViewControllerLifeCicle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewController()
        setupViewModel()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.hideTabBarController()
    }
    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "webViewUser"{
            if let index = tableView.indexPathForSelectedRow {
                urlWebview = viewModel?.responseUsers?.users?[index.row].html_url
            }
            let userWebViewController = segue.destination as! UserWebViewController
            if let url = urlWebview {
                userWebViewController.urlUser = url
            }
        }
    }
    
    // MARK: - Private Functions
    private func setupViewModel() {
        viewModel = UsersViewModel()
        viewModel?.facthUsers(languageName: language)
        viewModel?.delegate = self
    }
    
    private func setupViewController() {
        activityIndicator.startAnimating()
        language = languageTxt
        tableView.tableFooterView = UIView()
    }
}

extension UsersTableviewController: UsersViewModelDelegate {
    func dataDidLoaded() {
        self.activityIndicator.stopAnimating()
        self.tableView.reloadData()
    }
}

extension UsersTableviewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let users = viewModel?.responseUsers?.users else {return 0}
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? UsersCell else {
            fatalError("UnvalidCell")
        }
        
        let viewModel = UsersCellViewModel(
            nameLabel: viewModel?.responseUsers?.users?[indexPath.row].login ?? "",
            linguagemLabel: language,
            userUrlImage: viewModel?.responseUsers?.users?[indexPath.row].avatar_url ?? ""
        )
        
        cell.configuration(viewModel: viewModel)
        
        return cell
    }
}
