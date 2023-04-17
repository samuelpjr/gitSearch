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

    func facthRepositories(languageName: String, completion: @escaping () -> Void) {
        Service.shared.execute(.listRepositories(languageName), expecting: RepoResponse.self) { result in
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    self.response = success
                    completion()
                }
            case .failure(let failure):
                print(failure)
                completion()
            }
        }
    }
}

