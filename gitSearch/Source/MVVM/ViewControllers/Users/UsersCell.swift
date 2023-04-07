//
//  UsersCell.swift
//  gitSearch
//
//  Created by Samuel Pinheiro Junior on 21/09/17.
//  Copyright © 2017 Samuel Pinheiro Junior. All rights reserved.
//

import UIKit

class UsersCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var linguagemLabel: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    
    fileprivate func configureImage(_ image: UIImage?) {
        userImage.image = image
        userImage.layer.cornerRadius = 5
        userImage.clipsToBounds = true
    }
    
    func configuration(viewModel: UsersCellViewModel)  {
        self.nameLabel.text = viewModel.nameLabel
        self.linguagemLabel.text = viewModel.linguagemLabel
        viewModel.fetchImage { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.sync { [self] in
                    let image = UIImage(data: data)
                    self.configureImage(image)
                }
            case .failure(_):
                break
            }
        }
    }
}
