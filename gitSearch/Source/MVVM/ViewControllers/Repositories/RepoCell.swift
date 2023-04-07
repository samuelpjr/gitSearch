//
//  GSCell.swift
//  gitSearch
//
//  Created by Samuel Pinheiro Junior on 20/09/17.
//  Copyright © 2017 Samuel Pinheiro Junior. All rights reserved.
//
import UIKit

class RepoCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var linguagemLabel: UILabel!
    @IBOutlet weak var repoImage: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        linguagemLabel.text = nil
        repoImage.image = nil
    }
    
    fileprivate func configureImage(_ image: UIImage?) {
        self.repoImage.image = image
        self.repoImage.layer.cornerRadius = 5
        self.repoImage.clipsToBounds = true
    }
    
    func configure(with viewModel: RepoCellViewModel) {
        nameLabel.text = viewModel.name
        linguagemLabel.text = viewModel.linguage
        
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
