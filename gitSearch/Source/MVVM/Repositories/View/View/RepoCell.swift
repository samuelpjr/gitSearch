//
//  GSCell.swift
//  gitSearch
//
//  Created by Samuel Pinheiro Junior on 20/09/17.
//  Copyright © 2017 Samuel Pinheiro Junior. All rights reserved.
//
import UIKit

class RepoCell: UITableViewCell {
    
    
    lazy var nameLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var linguagemLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var repoImage: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    static var identifier = "RepoCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("RepoCell unaceptable")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        linguagemLabel.text = nil
        repoImage.image = nil
    }
    
    func setupView() {
        contentView.addSubviews(repoImage, nameLabel, linguagemLabel)
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            repoImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            repoImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            repoImage.widthAnchor.constraint(equalToConstant: 50),
            repoImage.heightAnchor.constraint(equalToConstant: 50),
            
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            nameLabel.leftAnchor.constraint(equalTo: repoImage.rightAnchor, constant: 10),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            linguagemLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            linguagemLabel.leftAnchor.constraint(equalTo: repoImage.rightAnchor, constant: 10),
            linguagemLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
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
