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
    private let managerUsers = UsersManager()
    private var responseUsers: UsersResponse?
    private var language: String = ""
    private let type = "users"
    private var urlWebview: String?
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Public properties
    var languageTxt: String = ""
   
    
    // MARK: Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        setup()
        featchUsers()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.hide()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "webViewUser"{
            if let index = tableView.indexPathForSelectedRow {
                urlWebview = responseUsers?.users[index.row].html_url
            }
            let userWebViewController = segue.destination as! UserWebViewController
            if let url = urlWebview {
                userWebViewController.urlUser = url
            }
        }
    }
    
    // MARK: - Private Functions
    fileprivate func setup() {
        language = languageTxt
        tableView.tableFooterView = UIView()
    }
    
    fileprivate func featchUsers() {
        managerUsers.facthUsers(type: type, name: language) { (responseUsers) in
            self.responseUsers = responseUsers
            self.activityIndicator.stopAnimating()
            self.tableView.reloadData()
        }
    }
}

extension UsersTableviewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if responseUsers != nil {
            return (responseUsers?.users.count)!
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UsersCell
        cell.nameLabel.text = responseUsers?.users[indexPath.row].name
        cell.linguagemLabel.text = language
        let url = URL(string:(responseUsers?.users[indexPath.row].avatar_url)!)
        let data = try? Data(contentsOf: url!)
        cell.userImage.image = UIImage(data: data!)
        cell.userImage.layer.cornerRadius = 5
        cell.userImage.clipsToBounds = true
        return cell
    }
}
