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
        view.backgroundColor = .milkWhite
        configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        self.navigationItem.title = "Profile"
        
        let logoutButton = createCustomLogoutButton(selector: #selector(logoutButtonTapped))
        navigationItem.rightBarButtonItem = logoutButton
    }
    
    @objc
    private func logoutButtonTapped() {
        let alert = UIAlertController(title: "До новых встреч", message: "Вы вышли из своего профиля", preferredStyle: .alert)
        self.present(alert, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let welcomeViewController = WelcomeViewController()
            self.view.window?.rootViewController = welcomeViewController
            self.view.window?.makeKeyAndVisible()
        }
    }
}
