//
//  UIButtonExtention.swift
//  gitSearch
//
//  Created by Samuel Pinheiro Junior on 12/04/23.
//  Copyright © 2023 Samuel Pinheiro Junior. All rights reserved.
//

import UIKit

extension UIButton {
    
    func createImageButton(title: String, imageName: String) {
        translatesAutoresizingMaskIntoConstraints = false
        setTitle(title, for: .normal)
        setTitleColor(.clear, for: .normal)
        setBackgroundImage(UIImage(named: imageName), for: .normal)
    }
}
