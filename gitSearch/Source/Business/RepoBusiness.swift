//
//  Business.swift
//  gitSearch
//
//  Created by Samuel Pinheiro Junior on 20/09/17.
//  Copyright © 2017 Samuel Pinheiro Junior. All rights reserved.
//

import Foundation

class RepoBusiness {
    
    func facthRepositories(type: String, LanguageName : String, callback : @escaping ((RepoResponse!) -> Void)){
        if let url = URL(string: "https://api.github.com/search/\(type)?q=language:\(LanguageName)&sort=stars&order=desc") {
            let tarefa = URLSession.shared.dataTask(with: url) { (dados, requisicao, erro) in
                do{
                    if erro == nil{
                        if let objetoJason = try JSONSerialization.jsonObject(with: dados!, options: []) as? [String : Any]{
                            let response = RepoResponse(fromJson: objetoJason as [String : Any])
                            callback(response)
                        } else {
                            print("error objetoJason")
                        }
                    } else {
                        print("Error session: \(String(describing: erro!))")
                    }
                } catch {
                   print("Error catch: \(String(describing: erro!))")
                }
            }
            tarefa.resume()
        }
    }
    
}
