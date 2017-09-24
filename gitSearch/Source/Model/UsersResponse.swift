//
//  ResponseUsers.swift
//  gitSearch
//
//  Created by Samuel Pinheiro Junior on 21/09/17.
//  Copyright © 2017 Samuel Pinheiro Junior. All rights reserved.
//

import Foundation

class UsersResponse {
    
    var users = [Users]()
    
    init(fromJson data:[String: Any]) {
        if let items = data["items"] as? [[String: Any]] {
            for item in items {
                users.append(Users(fromJson: item))
            }
        }
    }
}
