//
//  RepoCellViewModel.swift
//  gitSearch
//
//  Created by Samuel Pinheiro Junior on 07/04/23.
//  Copyright © 2023 Samuel Pinheiro Junior. All rights reserved.
//

import Foundation


class RepoCellViewModel {
    var name: String
    var linguage: String
    var urlImage: String?
    
    init(name: String, linguage: String, urlImage: String?) {
        self.name = name
        self.linguage = linguage
        self.urlImage = urlImage
    }
    
    func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {
        guard let stringUrl = urlImage,
              let url = URL(string: stringUrl) else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        ImageLoader.shared.downloadImage(url, completion: completion)
    }
}
