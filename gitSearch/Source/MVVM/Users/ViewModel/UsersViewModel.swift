//
//  ManagerUsers.swift
//  gitSearch
//
//  Created by Samuel Pinheiro Junior on 21/09/17.
//  Copyright © 2017 Samuel Pinheiro Junior. All rights reserved.
//

import Foundation

protocol UsersViewModelDelegate: AnyObject {
    func didSelectLanguage(_ language: String)
}

class UsersViewModel {
    
    var responseUsers: UsersResponse?
    var languageName: String?
    
    func facthUsers(languageName: String, completion: @escaping () -> Void) {
        Service.shared.execute(.listUsers(languageName), expecting: UsersResponse.self) { result in
            switch result {
            case .success(let success):
                DispatchQueue.main.sync { [self] in
                    self.responseUsers = success
                    self.languageName = languageName
                    completion()
                }
            case .failure(let failure):
                print(failure)
                completion()
            }
        }
    }
}
