//
//  UsersViewController.swift
//  gitSearch
//
//  Created by Samuel Pinheiro Junior on 21/09/17.
//  Copyright © 2017 Samuel Pinheiro Junior. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController, AnimatableTabBarController {

    // MARK: - Private properties
    var usersView = UsersView()
    
    // MARK: Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Users"
        usersView.delegate = self
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.showTabBarController()
    }
    
    fileprivate func setupView() {
        view.addSubview(usersView)
        
        NSLayoutConstraint.activate([
            usersView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            usersView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            usersView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            usersView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            
        ])
    }
}

extension UsersViewController: UsersViewDelegate {
    // MARK: Navigation
    func goToUsersList(_ language: String) {
        
        let viewModel = UsersViewModel()
        
        viewModel.facthUsers(languageName: language) { [self] in
            let repolistViewController = UsersTableviewController(viewModel: viewModel)
            usersView.spinner.stopAnimating()
            self.navigationController?.pushViewController(repolistViewController, animated: true)
        }
    }
}
