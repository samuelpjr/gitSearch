//
//  ImageLoader.swift
//  gitSearch
//
//  Created by Samuel Pinheiro Junior on 17/04/23.
//  Copyright © 2023 Samuel Pinheiro Junior. All rights reserved.
//

import Foundation

class ImageLoader {
    
    static let shared = ImageLoader()
    
    private var imageDataCach = NSCache<NSString, NSData>()
    
    private init() { }
    
    public func downloadImage(_ url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        
        let key = url.absoluteString as NSString
        if let data = imageDataCach.object(forKey: key) {
            completion(.success(data as Data))
            return
        }
        
        let urlRequest = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }
            
            let value = data as NSData
            self.imageDataCach.setObject(value, forKey: key)
            completion(.success(data))
        }
        task.resume()
    }
}
