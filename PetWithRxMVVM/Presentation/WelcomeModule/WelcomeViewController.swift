//
//  LoginViewController.swift
//  PetWithRxMVVM
//
//  Created by Artem Shilov on 08.08.2022.
//

import UIKit

final class WelcomeViewController: UIViewController {

    //MARK: - Properties

    private lazy var contentView: WelcomeView = {
        let contentView = WelcomeView()
        contentView.delegate = self
        return contentView
    }()

    //MARK: - Lifecycle

    override func loadView() {
        super.loadView()
        view = contentView
    }
}

//MARK: - WelcomeViewProtocol

extension WelcomeViewController: WelcomeViewProtocol {

    func loginButtonClicked() {
        let loginViewController = LoginViewController(loginViewModel: LoginViewModel(firebaseManager: FirebaseManager()))
        loginViewController.modalPresentationStyle = .fullScreen
        self.present(loginViewController, animated: true)
    }

    func buttonCreateAccountClicked() {
        let signUpViewController = SignUpViewController()
        self.present(signUpViewController, animated: true)
    }
}
