//
//  Manager.swift
//  gitSearch
//
//  Created by Samuel Pinheiro Junior on 20/09/17.
//  Copyright © 2017 Samuel Pinheiro Junior. All rights reserved.
//

import Foundation

class RepoManager {
    
    private var operationQueue = OperationQueue.main
    private var business = RepoBusiness()
    
    func facthRepositories(type: String, name : String, callback : @escaping ((RepoResponse!) -> Void)){
        business.facthRepositories(type: type, LanguageName: name) { (response) in
            self.operationQueue.addOperation {
                callback(response)
            }
        }
    }
}
