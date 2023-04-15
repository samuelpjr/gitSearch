//
//  RootTabBarController.swift
//  gitSearch
//
//  Created by Samuel Pinheiro Junior on 11/04/23.
//  Copyright © 2023 Samuel Pinheiro Junior. All rights reserved.
//

import UIKit

class RootTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        view.backgroundColor = .systemBackground
    }
    
    func setupTabs() {
        let repositoriesViewController = RepoViewController()
        let usersViewController = UsersViewController()
        
        let repositoriesNavigationController = UINavigationController(rootViewController: repositoriesViewController)
        let usersNavigationController = UINavigationController(rootViewController: usersViewController)
        
        repositoriesNavigationController.tabBarItem = UITabBarItem(
            title: "Repositories",
            image: UIImage(systemName: "person.circle"),
            tag: 1
        )
        usersNavigationController.tabBarItem = UITabBarItem(
            title: "Users",
            image: UIImage(systemName: "folder.circle"),
            tag: 2
        )
        
        let navigationViewControllerList = [repositoriesNavigationController, usersNavigationController]
        
        for nav in navigationViewControllerList {
            nav.navigationBar.prefersLargeTitles = true
        }
        
        setViewControllers(navigationViewControllerList, animated: true)
    }
}
