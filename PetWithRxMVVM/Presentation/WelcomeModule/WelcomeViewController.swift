//
//  LoginViewController.swift
//  PetWithRxMVVM
//
//  Created by Artem Shilov on 08.08.2022.
//

import UIKit

final class WelcomeViewController: UIViewController {

    //MARK: - Properties

    private lazy var welcomeContentView: WelcomeView = {
        let welcomeContentView = WelcomeView()
        welcomeContentView.delegate = self
        return welcomeContentView
    }()

    //MARK: - Lifecycle

    override func loadView() {
        super.loadView()
        view = welcomeContentView
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
        let signUpViewController = SignUpViewController(signUpViewModel: SignUpViewModel(firebaseManager: FirebaseManager()))
        self.present(signUpViewController, animated: true)
    }
}
