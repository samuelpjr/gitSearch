//
//  RepoView.swift
//  gitSearch
//
//  Created by Samuel Pinheiro Junior on 11/04/23.
//  Copyright © 2023 Samuel Pinheiro Junior. All rights reserved.
//

import UIKit

protocol RepoViewDelegate: AnyObject {
    func goToRepoList(_ language: String)
}

class RepoView: UIView {
    
    weak var delegate: RepoViewDelegate?
    
    lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    lazy var subtitleView: UILabel = {
        let label = UILabel()
        label.text = "Choose a language clicking on image below to find a repository."
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var swiftButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.createImageButton(title: "swift", imageName: "swift-og")
        button.addTarget(self, action: #selector(self.imageButtonTapped(_:)), for: .touchUpInside)
        
        return button
    }()
    
    lazy var javaButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.createImageButton(title: "java", imageName: "javaicone")
        button.addTarget(self, action: #selector(self.imageButtonTapped(_:)), for: .touchUpInside)
        
        return button
    }()
    
    lazy var javaScriptButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.createImageButton(title: "javascript", imageName: "javascript")
        button.addTarget(self, action: #selector(self.imageButtonTapped(_:)), for: .touchUpInside)
        
        return button
    }()
    
    lazy var rubyButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.createImageButton(title: "ruby", imageName: "icon.ruby")
        button.addTarget(self, action: #selector(self.imageButtonTapped(_:)), for: .touchUpInside)
        
        return button
    }()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        addingSubviews()
        setupConstraints()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("RepoView Usuported")
    }
    
    func addingSubviews() {
        addSubviews(subtitleView, containerView, spinner)
        containerView.addSubviews(swiftButton, javaButton, javaScriptButton, rubyButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            subtitleView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            subtitleView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            subtitleView.rightAnchor.constraint(equalTo: layoutMarginsGuide.rightAnchor),
            
            containerView.widthAnchor.constraint(equalToConstant: 350),
            containerView.heightAnchor.constraint(equalToConstant: 350),
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: centerYAnchor),

            swiftButton.widthAnchor.constraint(equalToConstant: 160),
            swiftButton.heightAnchor.constraint(equalToConstant: 160),
            swiftButton.topAnchor.constraint(equalTo: containerView.topAnchor),
            swiftButton.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            
            javaScriptButton.widthAnchor.constraint(equalToConstant: 160),
            javaScriptButton.heightAnchor.constraint(equalToConstant: 160),
            javaScriptButton.topAnchor.constraint(equalTo: containerView.topAnchor),
            javaScriptButton.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            
            javaButton.widthAnchor.constraint(equalToConstant: 160),
            javaButton.heightAnchor.constraint(equalToConstant: 160),
            javaButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            javaButton.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            
            rubyButton.widthAnchor.constraint(equalToConstant: 160),
            rubyButton.heightAnchor.constraint(equalToConstant: 160),
            rubyButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            rubyButton.rightAnchor.constraint(equalTo: containerView.rightAnchor)
        ])
    }
    
    @objc func imageButtonTapped(_ sender: UIButton) {
        guard let language = sender.titleLabel?.text else {
            fatalError("image button tapped with out titleLabel")
        }
        didSelectLanguage(language)
    }
}

extension RepoView: RepositoriesViewModelDelegate {
    func didSelectLanguage(_ linguage: String) {
            spinner.startAnimating()
            delegate?.goToRepoList(linguage)
    }
}

