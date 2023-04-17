//
//  ResponseUsers.swift
//  gitSearch
//
//  Created by Samuel Pinheiro Junior on 21/09/17.
//  Copyright © 2017 Samuel Pinheiro Junior. All rights reserved.
//

import Foundation

struct UsersResponse: Codable {
    var users: [UsersItem]?
    
    enum CodingKeys: String, CodingKey {
        case users = "items"
    }
}

struct UsersItem: Codable {
    var avatar_url: String?
    var html_url: String?
    var login: String?
}
