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

    private lazy var contentView: LoginView = {
        let contentView = LoginView()
        contentView.delegate = self
        return contentView
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
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        loginViewModel.authState.subscribe(onNext: { [weak self] type in
            guard let self = self else { return }

            switch type {
            case .succsess:
                self.contentView.activityIndicator.isHidden = true
                self.contentView.activityIndicator.stopAnimating()
                self.contentView.errorLabel.textColor = .green
                self.contentView.errorLabel.text = "Все верно"
                let alert = UIAlertController(title: "Ура!",
                                              message: "Авторизация прошла успешно",
                                              preferredStyle: .alert)
                self.present(alert, animated: true)
                self.goToNextScreen()

            case .failure:
                self.contentView.activityIndicator.isHidden = true
                self.contentView.activityIndicator.stopAnimating()
                self.contentView.errorLabel.textColor = .red
                self.contentView.errorLabel.text = "Неверные логин или пароль"
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
        self.contentView.activityIndicator.isHidden = false
        self.contentView.activityIndicator.startAnimating()
        loginViewModel.login(email: email, password: password)
    }

    func dismissButtonClicked() {
        self.dismiss(animated: true)
    }
}
