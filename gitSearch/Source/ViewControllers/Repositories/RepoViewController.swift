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
    private var languageTxt: String = ""
    
    // MARK: Controller
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.show()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "repositories"{
            if let button = sender as? UIButton {
                guard let titleButton = button.currentTitle else {
                    print("title button empty")
                    return
                }
                languageTxt = titleButton
            }
            let repoTableViewController = segue.destination as! RepoTableViewController
            repoTableViewController.languageTxt = languageTxt
        }
    }

    // MARK: Action
    @IBAction func tapLanguage(_ sender: UIButton) {
        guard let titleButton = sender.currentTitle else {
            print("title button empty")
            return
        }
        languageTxt = titleButton
        performSegue(withIdentifier: "repositories", sender: sender)
    }
}
