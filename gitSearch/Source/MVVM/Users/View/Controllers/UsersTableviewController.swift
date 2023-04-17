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
    private var viewModel: UsersViewModel
    
    var tableView = UITableView()
   
    // MARK: ViewControllerLifeCicle
    init(viewModel: UsersViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("UsersTableViewController unaceptable")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Users List"
        setupTableView()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.hideTabBarController()
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
        
        tableView.register(UsersCell.self, forCellReuseIdentifier: UsersCell.identifier)
        
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

extension UsersTableviewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let users = viewModel.responseUsers?.users else {
            print("numberOfRowsInSection is empty")
            return 0
        }
        
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UsersCell.identifier, for: indexPath) as? UsersCell else {
            fatalError("UnvalidCell")
        }
        
        let viewModel = UsersCellViewModel(
            nameLabel: viewModel.responseUsers?.users?[indexPath.row].login ?? "",
            linguagemLabel: viewModel.languageName ?? "",
            userUrlImage: viewModel.responseUsers?.users?[indexPath.row].avatar_url ?? ""
        )
        
        cell.configuration(viewModel: viewModel)
        
        return cell
    }
}

extension UsersTableviewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let urlWebview = viewModel.responseUsers?.users?[indexPath.row].html_url

        if let url = urlWebview {
            let userWebViewController = UserWebViewController(urlUser: url)
            navigationController?.pushViewController(userWebViewController, animated: true)
        }
    }
}
