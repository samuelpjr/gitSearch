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
    private let manager = RepoManager()
    private var response: RepoResponse?
    private var language: String = ""
    private let type = "repositories"
    private var urlWebview: String?
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Public properties
    var languageTxt: String = ""
    var activityIndicator = UIActivityIndicatorView()
    
    // MARK: Controllers
    override func viewDidLoad() {
        super.viewDidLoad()
        showActivitIndicator()
        setup()
        featchRepositories()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.hide()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "webviewRepo"{
            if let index = tableView.indexPathForSelectedRow {
                urlWebview = response?.repositorios[index.row].html_url
            }
            let repoWebViewController = segue.destination as! RepoWebViewController
            if let url = urlWebview{
                repoWebViewController.urlRepo = url
            }
        }
    }
    
    // MARK: - Private Functions
    fileprivate func featchRepositories() {
        manager.facthRepositories(type: type, name: language) { (response) in
            self.response = response
            self.activityIndicator.stopAnimating()
            self.tableView.reloadData()
        }
    }
    
    fileprivate func setup() {
        language = languageTxt
        tableView.tableFooterView = UIView()
    }
    
    private func showActivitIndicator(){
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }

}

extension RepoTableViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if response != nil {
            return (response?.repositorios.count)!
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RepoCell
        cell.nameLabel.text = response?.repositorios[indexPath.row].name
        cell.linguagemLabel.text = response?.repositorios[indexPath.row].language
        let url = URL(string:(response?.repositorios[indexPath.row].avatar_url)!)
        let data = try? Data(contentsOf: url!)
        cell.repoImage.image = UIImage(data: data!)
        cell.repoImage.layer.cornerRadius = 5
        cell.repoImage.clipsToBounds = true
        return cell
    }
    
   
}


