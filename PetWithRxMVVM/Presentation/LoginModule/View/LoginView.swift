//
//  LoginView.swift
//  PetWithRxMVVM
//
//  Created by Artem Shilov on 01.09.2022.
//

import UIKit
import SnapKit

protocol LoginViewProtocol: AnyObject {
    func loginButtonClicked(email: String, password: String)
    func dismissButtonClicked()
}

final class LoginView: UIView {

    //MARK: - Properties

    weak var delegate: LoginViewProtocol?

    lazy var errorLabel: UILabel = {
        let errorLabel = UILabel()
        errorLabel.font = UIFont.systemFont(ofSize: 20)
        errorLabel.text = ""
        errorLabel.numberOfLines = 0
        errorLabel.textAlignment = .center
        errorLabel.textColor = .clear
        return errorLabel
    }()

    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.isHidden = true
        return activityIndicator
    }()

    private lazy var loginLabel: UILabel = {
        let loginLabel = UILabel()
        loginLabel.text = "Войдите в Ваш аккаунт"
        loginLabel.font = .systemFont(ofSize: 24)
        loginLabel.textColor = .black
        loginLabel.textAlignment = .center
        loginLabel.numberOfLines = 0
        return loginLabel
    }()

    private lazy var emailTextField: UITextField = {
        let emailTextField = UITextField()
        emailTextField.textColor = .black
        emailTextField.backgroundColor = .white
        emailTextField.placeholder = "Email"
        emailTextField.keyboardType = .emailAddress
        emailTextField.layer.cornerRadius = 5
        emailTextField.font = UIFont.systemFont(ofSize: 20)
        emailTextField.clearButtonMode = .whileEditing
        return emailTextField
    }()

    private lazy var passwordTextField: UITextField = {
        let passwordTextField = UITextField()
        passwordTextField.textColor = .black
        passwordTextField.backgroundColor = .white
        passwordTextField.placeholder = "Пароль"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.layer.cornerRadius = 5
        passwordTextField.font = UIFont.systemFont(ofSize: 20)
        passwordTextField.clearButtonMode = .whileEditing
        return passwordTextField
    }()

    private lazy var loginButton: UIButton = {
        let loginButton = UIButton(type: .system)
        loginButton.layer.borderWidth = 3.0
        loginButton.layer.borderColor = CGColor.init(gray: 0, alpha: 1)
        loginButton.setTitle("Войти", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.titleLabel?.font = .systemFont(ofSize: 18)
        loginButton.layer.cornerRadius = 20
        loginButton.addTarget(self, action: #selector(loginButtonClicked), for: .touchUpInside)
        return loginButton
    }()

    private lazy var dismissButton: UIButton = {
        let createAccountButton = UIButton(type: .system)
        createAccountButton.layer.borderWidth = 3.0
        createAccountButton.layer.borderColor = CGColor.init(gray: 0, alpha: 1)
        createAccountButton.setTitle("Назад", for: .normal)
        createAccountButton.setTitleColor(.white, for: .normal)
        createAccountButton.titleLabel?.font = .systemFont(ofSize: 18)
        createAccountButton.layer.cornerRadius = 20
        createAccountButton.addTarget(self, action: #selector(dismissButtonClicked), for: .touchUpInside)
        return createAccountButton
    }()

    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLoginView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Methods

    private func configureLoginView() {
        backgroundColor = .milfPurple
        configureLoginLabel()
        configureEmailTextField()
        configurePasswordTextField()
        configureDismissButton()
        configureLoginButton()
        configureErrorLabel()
        cofigureActivityIndicator()
    }

    private func configureLoginLabel() {
        addSubview(loginLabel)
        loginLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(50)
            make.left.right.equalToSuperview().inset(50)
        }
    }

    private func configureEmailTextField() {
        addSubview(emailTextField)
        emailTextField.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(loginLabel.snp.bottom).offset(100)
        }
    }

    private func configurePasswordTextField() {
        addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(emailTextField.snp.bottom).offset(50)
        }
    }

    private func configureDismissButton() {
        addSubview(dismissButton)
        dismissButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(60)
            make.width.equalTo(250)
            make.height.equalTo(50)
        }
    }

    private func configureLoginButton() {
        addSubview(loginButton)
        loginButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(dismissButton.snp.top).offset(-15)
            make.width.equalTo(250)
            make.height.equalTo(50)
        }
    }

    private func configureErrorLabel() {
        addSubview(errorLabel)
        errorLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(passwordTextField.snp.bottom).offset(50)
        }
    }

    private func cofigureActivityIndicator() {
        addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(loginButton.snp.top).offset(-20)
        }
    }

    @objc
    private func loginButtonClicked(_ sender: UIButton) {
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }

        delegate?.loginButtonClicked(email: email, password: password)
    }

    @objc
    private func dismissButtonClicked(_ sender: UIButton) {
        delegate?.dismissButtonClicked()
    }
}
