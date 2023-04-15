//
//  Manager.swift
//  gitSearch
//
//  Created by Samuel Pinheiro Junior on 20/09/17.
//  Copyright © 2017 Samuel Pinheiro Junior. All rights reserved.
//

import Foundation

protocol RepositoriesViewModelDelegate: AnyObject {
    func didSelectLanguage(_ language: String)
}

class RepositoriesViewModel {
    
    var response: RepoResponse?
    weak var delegate: RepositoriesViewModelDelegate?

    func facthRepositories(languageName: String, complition: @escaping () -> Void) {
        Service.shared.execute(.listRepositories(languageName), expecting: RepoResponse.self) { result in
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    self.response = success
                    complition()
                }
            case .failure(let failure):
                print(failure)
                complition()
            }
        }
    }
}

