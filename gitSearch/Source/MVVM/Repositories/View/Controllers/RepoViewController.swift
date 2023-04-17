//
//  RepositoriesTabBarViewController.swift
//  gitSearch
//
//  Created by Samuel Pinheiro Junior on 20/09/17.
//  Copyright © 2017 Samuel Pinheiro Junior. All rights reserved.
//

import UIKit

class RepoViewController: UIViewController, AnimatableTabBarController {
    
    // MARK: - Private properties
    private let repoView: RepoView = RepoView()
    
    // MARK: ViewControllerLifeCicle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Repositories"
        repoView.delegate = self
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.showTabBarController()
    }
    
    fileprivate func setupView() {
        view.addSubview(repoView)
        
        NSLayoutConstraint.activate([
            repoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            repoView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            repoView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            repoView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            
        ])
    }
}

extension RepoViewController: RepoViewDelegate {
    // MARK: Navigation
    func goToRepoList(_ language: String) {
        let viewModel = RepositoriesViewModel()
        viewModel.facthRepositories(languageName: language) { [self] in
            let repolistViewController = RepoTableViewController(viewModel: viewModel)
            repoView.spinner.stopAnimating()
            self.navigationController?.pushViewController(repolistViewController, animated: true)
        }
    }
}
