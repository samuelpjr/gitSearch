//
//  Response.swift
//  gitSearch
//
//  Created by Samuel Pinheiro Junior on 20/09/17.
//  Copyright © 2017 Samuel Pinheiro Junior. All rights reserved.
//

import Foundation

class RepoResponse {
    
    var repositorios = [Repositorio]()
    
    init(fromJson data:[String: Any]) {
        if let items = data["items"] as? [[String: Any]] {
            for item in items {
                repositorios.append(Repositorio(fromJson: item))
            }
        }
    }
}
