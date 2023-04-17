//
//  Service.swift
//  gitSearch
//
//  Created by Samuel Pinheiro Junior on 06/04/23.
//  Copyright © 2023 Samuel Pinheiro Junior. All rights reserved.
//

import Foundation

class Service {
    
    enum ServiceError: Error {
        case failedToCreateRequest
        case failedToGetData
        case failedToDecodeJason
    }
    
    static let shared = Service()
    
    private init() {}
    
    public func execute<T: Codable>(_ request: Request, expecting type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        
        guard let urlRequest = self.request(from: request) else {
            completion(.failure(ServiceError.failedToCreateRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            
            guard let data = data, error == nil else {
                completion(.failure(error ?? ServiceError.failedToGetData))
                return
            }
            
            
            
            do{
                let result = try JSONDecoder().decode(type.self, from: data)
//                print(result)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    private func request(from gitRequest: Request) -> URLRequest? {
        guard let url = gitRequest.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = gitRequest.httpMethod
        return request
    }
}
