//
//  File.swift
//  gitSearch
//
//  Created by Samuel Pinheiro Junior on 22/09/17.
//  Copyright © 2017 Samuel Pinheiro Junior. All rights reserved.
//


import UIKit

protocol AnimatableTabBarController{
    
}

///
/// Customization and animation of the tab bar
///
extension AnimatableTabBarController where Self: UIViewController {
    
    func showTabBarController() {
        self.tabBarController?.tabBar.alpha = 0.0
        self.tabBarController?.tabBar.isHidden = false
        UIView.animate(withDuration: 0.2) {
            self.tabBarController?.tabBar.alpha = 1.0
        }
    }
    
    func hideTabBarController() {
        tabBarController?.tabBar.alpha = 1.0
        UIView.animate(withDuration: 0.2, animations: {
            self.tabBarController?.tabBar.alpha = 0.0
        }) { (finished: Bool) in
            self.tabBarController?.tabBar.isHidden = true
        }
        view.setNeedsLayout()
    }
}
