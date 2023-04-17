//
//  UsersCell.swift
//  gitSearch
//
//  Created by Samuel Pinheiro Junior on 21/09/17.
//  Copyright © 2017 Samuel Pinheiro Junior. All rights reserved.
//

import UIKit

class UsersCell: UITableViewCell {
    
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
    
    var userImage: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    static var identifier = "UserCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("UserCell unaceptable")
    }
    
    
    func setupView() {
        contentView.addSubviews(userImage, nameLabel, linguagemLabel)
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            userImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            userImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            userImage.widthAnchor.constraint(equalToConstant: 50),
            userImage.heightAnchor.constraint(equalToConstant: 50),
            
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            nameLabel.leftAnchor.constraint(equalTo: userImage.rightAnchor, constant: 10),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            linguagemLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            linguagemLabel.leftAnchor.constraint(equalTo: userImage.rightAnchor, constant: 10),
            linguagemLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
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
