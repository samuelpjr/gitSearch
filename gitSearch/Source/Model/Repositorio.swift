//
//  Repositorio.swift
//  gitSearch
//
//  Created by Samuel Pinheiro Junior on 20/09/17.
//  Copyright © 2017 Samuel Pinheiro Junior. All rights reserved.
//

import Foundation

class Repositorio{
    
    var avatar_url: String?
    var language: String?
    var name: String?
    var html_url: String?
    
    init(fromJson data:[String: Any]) {
        name = data["name"] as? String
        language = data["language"] as? String
        if let owner = data["owner"] as? [String: Any] {
            avatar_url = owner["avatar_url"] as? String
            html_url = owner["html_url"] as? String
        }
    }
}
