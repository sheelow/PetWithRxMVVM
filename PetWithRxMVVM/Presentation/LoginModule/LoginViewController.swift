//
//  LoginViewController.swift
//  PetWithRxMVVM
//
//  Created by Artem Shilov on 08.08.2022.
//

import UIKit

final class LoginViewController: BaseViewController {

    //MARK: - Properties

    private var loginViewModel: LoginViewModelProtocol

    private lazy var loginContentView: LoginView = {
        let loginContentView = LoginView()
        loginContentView.delegate = self
        return loginContentView
    }()

    //MARK: - Lifecycle

    init(loginViewModel: LoginViewModelProtocol) {
        self.loginViewModel = loginViewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()
        view = loginContentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        loginViewModel.authState.subscribe(onNext: { [weak self] type in
            guard let self = self else { return }

            switch type {
            case .succsess:
                self.loginContentView.activityIndicator.isHidden = true
                self.loginContentView.activityIndicator.stopAnimating()
                self.loginContentView.errorLabel.textColor = .clear
                let alert = UIAlertController(title: "Ура!",
                                              message: "Авторизация прошла успешно",
                                              preferredStyle: .alert)
                self.present(alert, animated: true)
                self.goToNextScreen()

            case .failure:
                self.loginContentView.activityIndicator.isHidden = true
                self.loginContentView.activityIndicator.stopAnimating()
                self.loginContentView.errorLabel.textColor = .red
                self.loginContentView.errorLabel.text = "Неверные логин или пароль"
            }
        }).disposed(by: disposeBag)
    }

    //MARK: - Methods

    private func goToNextScreen() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let mainTabBarController = MainTabBarController()
            self.view.window?.rootViewController = mainTabBarController
            self.view.window?.makeKeyAndVisible()
        }
    }
}

//MARK: - LoginViewProtocol

extension LoginViewController: LoginViewProtocol {

    func loginButtonClicked(email: String, password: String) {
        self.loginContentView.activityIndicator.isHidden = false
        self.loginContentView.activityIndicator.startAnimating()
        loginViewModel.login(email: email, password: password)
    }

    func dismissButtonClicked() {
        self.dismiss(animated: true)
    }
}
