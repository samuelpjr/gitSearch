//
//  Request.swift
//  gitSearch
//
//  Created by Samuel Pinheiro Junior on 06/04/23.
//  Copyright © 2023 Samuel Pinheiro Junior. All rights reserved.
//

import Foundation

class Request {
    
    private struct Constants {
        static let baseUrl = "https://api.github.com/search/"
    }
    
    private let endPoint: EndPoint
    private let pathComponents: [String]
    private let queryParamters: [URLQueryItem]
    
    private var urlString: String {
        var string = Constants.baseUrl
        string += endPoint.rawValue
        
        if !pathComponents.isEmpty {
            pathComponents.forEach {
                string += "/\($0)"
            }
        }
        
        if !queryParamters.isEmpty {
            string += "?"
            let argumentString = queryParamters.compactMap {
                guard let value = $0.value else { return nil }
                return "\($0.name)=\(value)"
            }.joined(separator: "&")
            string += argumentString
        }
        return string
    }
    
    public var url: URL? {
        URL(string: urlString)
    }
    
    public let httpMethod = "GET"
    
    public init(endPoint: EndPoint, pathComponents: [String] = [], queryParamters: [URLQueryItem] = []) {
        self.endPoint = endPoint
        self.pathComponents = pathComponents
        self.queryParamters = queryParamters
    }
}

extension Request {
    static var listRepositories: (String) -> Request {
        { name in
            Request(
                endPoint: .repositories,
                queryParamters: [
                    URLQueryItem(name: "q", value: "language:\(name)"),
                    URLQueryItem(name: "sort", value: "stars"),
                    URLQueryItem(name: "order", value: "desc")
                ]
            )
        }
    }
    
    static var listUsers: (String) -> Request {
        { name in
            Request(
                endPoint: .users,
                queryParamters: [
                    URLQueryItem(name: "q", value: "language:\(name)"),
                    URLQueryItem(name: "sort", value: "stars"),
                    URLQueryItem(name: "order", value: "desc")
                ]
            )
        }
    }
}
