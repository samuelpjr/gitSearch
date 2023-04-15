//
//  UIViewExtension.swift
//  gitSearch
//
//  Created by Samuel Pinheiro Junior on 11/04/23.
//  Copyright © 2023 Samuel Pinheiro Junior. All rights reserved.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        views.forEach {
            addSubview($0)
        }
    }
}

