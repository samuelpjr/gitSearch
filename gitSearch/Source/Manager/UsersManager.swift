//
//  ManagerUsers.swift
//  gitSearch
//
//  Created by Samuel Pinheiro Junior on 21/09/17.
//  Copyright © 2017 Samuel Pinheiro Junior. All rights reserved.
//

import Foundation

class UsersManager {
    
    private var operationQueue = OperationQueue.main
    private var businessUsers = UsersBusiness()
    
    func facthUsers(type: String, name : String, callback : @escaping ((UsersResponse!) -> Void)){
        businessUsers.facthUsers(type: type, LanguageName: name) { (responseUsers) in
            self.operationQueue.addOperation {
                callback(responseUsers)
            }
        }
    }
}
