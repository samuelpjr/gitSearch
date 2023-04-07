//
//  ViewController.swift
//  gitSearch
//
//  Created by Samuel Pinheiro Junior on 19/09/17.
//  Copyright © 2017 Samuel Pinheiro Junior. All rights reserved.
//

import UIKit




class RepoTableViewController: UIViewController, AnimatableTabBarController {
    
    // MARK: - Private properties
    private var viewModel: RepositoriesViewModel?
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
        if segue.identifier == "webviewRepo"{
            if let index = tableView.indexPathForSelectedRow {
                urlWebview = viewModel?.response?.repositorios?[index.row].owner?.html_url
            }
            let repoWebViewController = segue.destination as! RepoWebViewController
            if let url = urlWebview{
                repoWebViewController.urlRepo = url
            }
        }
    }
    
    // MARK: - Private Functions
    private func setupViewModel() {
        viewModel = RepositoriesViewModel()
        viewModel?.delegate = self
        viewModel?.facthRepositories(languageName: language)
    }
    
    private func setupViewController() {
        activityIndicator.startAnimating()
        language = languageTxt
        tableView.tableFooterView = UIView()
    }
}

extension RepoTableViewController: RepositoriesViewModelDelegate {
    func dataDidLoaded() {
        self.activityIndicator.stopAnimating()
        self.tableView.reloadData()
    }
}

extension RepoTableViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let repositories = viewModel?.response?.repositorios else {
            print("numberOfRowsInSection is empty")
            return 0
        }
        return repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? RepoCell else {
            fatalError("UnsuportedCell")
        }
        
        let viewmodel = RepoCellViewModel(
            name: viewModel?.response?.repositorios?[indexPath.row].name ?? "",
            linguage: viewModel?.response?.repositorios?[indexPath.row].language ?? "",
            urlImage: viewModel?.response?.repositorios?[indexPath.row].owner?.avatar_url
        )
        
        cell.configure(with: viewmodel)
        return cell
    }
}
