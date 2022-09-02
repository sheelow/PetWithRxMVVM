//
//  SignUpView.swift
//  PetWithRxMVVM
//
//  Created by Artem Shilov on 01.09.2022.
//

import UIKit
import SnapKit

protocol SignUpViewProtocol: AnyObject {
    func registerButtonClicked(name: String, lastName: String, email: String, password: String)
    func dismissButtonClicked()
}

final class SignUpView: UIView {

    //MARK: - Properties

    weak var delegate: SignUpViewProtocol?

    lazy var nameTextField: UITextField = {
        let nameTextField = UITextField()
        nameTextField.textColor = .black
        nameTextField.backgroundColor = .white
        nameTextField.placeholder = "Ваше Имя"
        nameTextField.layer.cornerRadius = 5
        nameTextField.font = UIFont.systemFont(ofSize: 20)
        nameTextField.clearButtonMode = .whileEditing
        return nameTextField
    }()

    lazy var lastNameTextField: UITextField = {
        let lastNameTextField = UITextField()
        lastNameTextField.textColor = .black
        lastNameTextField.backgroundColor = .white
        lastNameTextField.placeholder = "Ваша Фамилия"
        lastNameTextField.layer.cornerRadius = 5
        lastNameTextField.font = UIFont.systemFont(ofSize: 20)
        lastNameTextField.clearButtonMode = .whileEditing
        return lastNameTextField
    }()

    lazy var emailTextField: UITextField = {
        let emailTextField = UITextField()
        emailTextField.textColor = .black
        emailTextField.backgroundColor = .white
        emailTextField.placeholder = "Ваш Email"
        emailTextField.layer.cornerRadius = 5
        emailTextField.font = UIFont.systemFont(ofSize: 20)
        emailTextField.clearButtonMode = .whileEditing
        return emailTextField
    }()

    lazy var passwordTextField: UITextField = {
        let passwordTextField = UITextField()
        passwordTextField.textColor = .black
        passwordTextField.backgroundColor = .white
        passwordTextField.placeholder = "Ваш пароль"
        passwordTextField.layer.cornerRadius = 5
        passwordTextField.font = UIFont.systemFont(ofSize: 20)
        passwordTextField.clearButtonMode = .whileEditing
        return passwordTextField
    }()

    lazy var errorLabel: UILabel = {
        let errorLabel = UILabel()
        errorLabel.font = UIFont.systemFont(ofSize: 20)
        errorLabel.text = "Некорректные данные"
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

    private lazy var signUpLabel: UILabel = {
        let signUpLabel = UILabel()
        signUpLabel.text = "Тут регистрируемся!"
        signUpLabel.font = .systemFont(ofSize: 28)
        signUpLabel.textColor = .black
        signUpLabel.textAlignment = .center
        signUpLabel.numberOfLines = 1
        return signUpLabel
    }()

    private lazy var registerButton: UIButton = {
        let registerButton = UIButton(type: .system)
        registerButton.layer.borderWidth = 3.0
        registerButton.layer.borderColor = CGColor.init(gray: 0, alpha: 1)
        registerButton.setTitle("Зарегистрироваться", for: .normal)
        registerButton.setTitleColor(.white, for: .normal)
        registerButton.titleLabel?.font = .systemFont(ofSize: 18)
        registerButton.layer.cornerRadius = 20
        registerButton.addTarget(self, action: #selector(registerButtonClicked), for: .touchUpInside)
        return registerButton
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

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 30
        return stackView
    }()

    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSignUpView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Methods

    func showActivity() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    func hideActivity() {
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
    }
    
    private func configureSignUpView() {
        backgroundColor = .milfPink
        configureSignUpLabel()
        configureStackView()
        configureErrorLabel()
        configureDismissButton()
        configureRegisterButton()
        cofigureActivityIndicator()
    }

    private func configureSignUpLabel() {
        addSubview(signUpLabel)
        signUpLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(50)
            make.left.right.equalToSuperview().inset(50)
        }
    }

    private func configureStackView() {
        addSubview(stackView)

        stackView.addArrangedSubview(nameTextField)
        stackView.addArrangedSubview(lastNameTextField)
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)

        stackView.snp.makeConstraints { make in
            make.top.equalTo(signUpLabel.snp.bottom).offset(50)
            make.left.right.equalToSuperview().inset(20)
        }
    }

    private func configureErrorLabel() {
        addSubview(errorLabel)
        errorLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(stackView.snp.bottom).offset(50)
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

    private func configureRegisterButton() {
        addSubview(registerButton)
        registerButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(dismissButton.snp.top).offset(-15)
            make.width.equalTo(250)
            make.height.equalTo(50)
        }
    }

    private func cofigureActivityIndicator() {
        addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(registerButton.snp.top).offset(-20)
        }
    }

    @objc
    private func registerButtonClicked(_ sender: UIButton) {
        guard let name = nameTextField.text,
              let lastName = lastNameTextField.text,
              let email = emailTextField.text,
              let password = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }

        delegate?.registerButtonClicked(name: name, lastName: lastName, email: email, password: password)
    }

    @objc
    private func dismissButtonClicked(_ sender: UIButton) {
        delegate?.dismissButtonClicked()
    }
}
