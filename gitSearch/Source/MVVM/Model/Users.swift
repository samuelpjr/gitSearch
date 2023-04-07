//
//  Users.swift
//  gitSearch
//
//  Created by Samuel Pinheiro Junior on 21/09/17.
//  Copyright © 2017 Samuel Pinheiro Junior. All rights reserved.
//

import Foundation

class Users{
    
    var avatar_url: String?
    var html_url: String?
    var name: String?
    
    init(fromJson data:[String: Any]) {
        name = data["login"] as? String
        html_url = data["html_url"] as? String
        avatar_url = data["avatar_url"] as? String
        
    }
}
