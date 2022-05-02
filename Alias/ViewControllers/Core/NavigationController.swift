//
//  NavigationController.swift
//  Alias
//
//  Created by Victor Rubenko on 02.05.2022.
//

import UIKit

class NavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
    }
    
    private func setupAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.backgroundColor = Constants.Colors.navBarColor
        appearance.titleTextAttributes = [.foregroundColor: Constants.Colors.secondaryTextColor ?? .white]
        appearance.largeTitleTextAttributes = [.foregroundColor: Constants.Colors.textColor ?? .black]
        
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
    }
}
