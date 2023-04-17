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
    private let viewModel: RepositoriesViewModel
    
    var tableView = UITableView()
    
    // MARK: ViewControllerLifeCicle
    init(viewModel: RepositoriesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("RepoTableViewController unaceptable")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Repositories List"
        setupTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.hideTabBarController()
    }
    
    // MARK: - Private Functions
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
        
        tableView.register(RepoCell.self, forCellReuseIdentifier: RepoCell.identifier)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 60
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        
        ])
    }
}

extension RepoTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        guard let repositories = viewModel.response?.repositorios else {
            print("numberOfRowsInSection is empty")
            return 0
        }
        
        return repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RepoCell.identifier, for: indexPath) as? RepoCell else {
            fatalError("UnsuportedCell")
        }
        
        let viewmodel = RepoCellViewModel(
            name: viewModel.response?.repositorios?[indexPath.row].name ?? "",
            linguage: viewModel.response?.repositorios?[indexPath.row].language ?? "",
            urlImage: viewModel.response?.repositorios?[indexPath.row].owner?.avatar_url
        )
        
        cell.configure(with: viewmodel)
        return cell
    }
}

extension RepoTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let urlWebview = viewModel.response?.repositorios?[indexPath.row].owner?.html_url

        if let url = urlWebview {
            let repoWebViewController = RepoWebViewController(urlRepo: url)
            navigationController?.pushViewController(repoWebViewController, animated: true)
        }
    }
}
