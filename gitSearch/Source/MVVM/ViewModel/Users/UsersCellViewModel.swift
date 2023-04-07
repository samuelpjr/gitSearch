//
//  UsersCellViewModel.swift
//  gitSearch
//
//  Created by Samuel Pinheiro Junior on 07/04/23.
//  Copyright © 2023 Samuel Pinheiro Junior. All rights reserved.
//

import Foundation

class UsersCellViewModel {
    
    var nameLabel: String
    var linguagemLabel: String
    var userUrlImage: String
    
    init(nameLabel: String, linguagemLabel: String, userUrlImage: String) {
        self.nameLabel = nameLabel
        self.linguagemLabel = linguagemLabel
        self.userUrlImage = userUrlImage
    }
    
    func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: userUrlImage) else {
            fatalError("InvalidUrlImage")
        }
        
        let urlRequest = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            
            guard let data = data, error == nil else {
                fatalError("InvalidData")
            }
            
            completion(.success(data))
        }
        task.resume()
    }
}
