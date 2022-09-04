//
//  SignUpViewController.swift
//  PetWithRxMVVM
//
//  Created by Artem Shilov on 08.08.2022.
//

import UIKit
import FirebaseAuth
import Firebase

final class SignUpViewController: BaseViewController {

    //MARK: - Properties

    private var signUpViewModel: SignUpViewModelProtocol

    private lazy var signUpContentView: SignUpView = {
        let signUpContentView = SignUpView()
        signUpContentView.delegate = self
        return signUpContentView
    }()

    //MARK: - Lifecycle

    init(signUpViewModel: SignUpViewModelProtocol) {
        self.signUpViewModel = signUpViewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()
        view = signUpContentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        signUpViewModel.regState.subscribe(onNext: { [weak self] type in
            guard let self = self else { return }

            switch type {
            case .succsess:
                self.signUpContentView.errorLabel.textColor = .green
                self.signUpContentView.errorLabel.text = "Регистрация прошла успешно"
                self.signUpContentView.hideActivity()

                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.dismiss(animated: true)
                }

            case .failure:
                self.signUpContentView.hideActivity()
                self.showError("Ошибка сохранения данных")
            }
        }).disposed(by: disposeBag)
    }

    //MARK: - Methods

    private func validateFields() -> String? {
        if signUpContentView.nameTextField.text == "" ||
            signUpContentView.lastNameTextField.text == "" ||
            signUpContentView.emailTextField.text == "" ||
            signUpContentView.passwordTextField.text == "" {
            return "Заполните все поля"
        }

        guard let cleanName = signUpContentView.nameTextField.text,
              let cleanLastName = signUpContentView.lastNameTextField.text else { return nil }
        if Utilities.isNameValid(cleanName) == false || Utilities.isNameValid(cleanLastName) == false {
            return "Некорректные имя или фамилия"
        }

        guard let cleanEmail = signUpContentView.emailTextField.text else { return nil }
        if Utilities.isEmailValid(cleanEmail) == false {
            return "Некорректный email"
        }

        guard let cleanPassword = signUpContentView.passwordTextField.text else { return nil }
        if Utilities.isPasswordValid(cleanPassword) == false {
            return "Пароль должен содержать минимум 8 символов, включая числа и спец символы"
        }

        return nil
    }

    private func showError(_ message: String) {
        signUpContentView.errorLabel.textColor = .red
        signUpContentView.errorLabel.text = message
    }
}

//MARK: - SignUpViewProtocol

extension SignUpViewController: SignUpViewProtocol {

    func registerButtonClicked(name: String, lastName: String, email: String, password: String) {
        self.signUpContentView.showActivity()

        let error = validateFields()
        if error != nil {
            self.signUpContentView.hideActivity()

            guard let error = error else { return }
            showError(error)
        } else {
            signUpViewModel.register(name: name, lastName: lastName, email: email, password: password)
        }
    }

    func dismissButtonClicked() {
        self.dismiss(animated: true)
    }
}
