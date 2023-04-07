//
//  ManagerUsers.swift
//  gitSearch
//
//  Created by Samuel Pinheiro Junior on 21/09/17.
//  Copyright © 2017 Samuel Pinheiro Junior. All rights reserved.
//

import Foundation

protocol UsersViewModelDelegate: AnyObject {
    func dataDidLoaded()
}


class UsersViewModel {
    
    var responseUsers: UsersResponse?
    weak var delegate: UsersViewModelDelegate?
    
    func facthUsers(languageName: String) {
        Service.shared.execute(.listUsers(languageName), expecting: UsersResponse.self) { result in
            switch result {
            case .success(let success):
                DispatchQueue.main.sync { [self] in
                    self.responseUsers = success
                    self.delegate?.dataDidLoaded()
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
