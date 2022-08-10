//
//  ProfileViewController.swift
//  PetWithRxMVVM
//
//  Created by Artem Shilov on 09.08.2022.
//

import UIKit

class ProfileViewController: UIViewController {

    //MARK: - Properties
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 241/255, green: 238/255, blue: 228/255, alpha: 1)
        configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        self.navigationItem.title = "Profile"
        
        let logoutButton = createCustomLogoutButton(selector: #selector(logoutButtonTapped))
        navigationItem.rightBarButtonItem = logoutButton
    }
    
    @objc
    private func logoutButtonTapped() {
        self.dismiss(animated: true)
    }
}
