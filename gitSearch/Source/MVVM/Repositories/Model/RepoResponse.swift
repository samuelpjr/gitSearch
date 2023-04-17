//
//  Repositorio.swift
//  gitSearch
//
//  Created by Samuel Pinheiro Junior on 20/09/17.
//  Copyright © 2017 Samuel Pinheiro Junior. All rights reserved.
//

import Foundation
import UIKit


struct RepoResponse: Codable {
    var repositorios: [Item]?
    
    enum CodingKeys: String, CodingKey {
        case repositorios = "items"
    }
}
struct Item: Codable {
    var owner: Owner?
    var language: String?
    var name: String?
}

struct Owner: Codable {
    var avatar_url: String?
    var html_url: String?
}
