//
//  SignUpViewController.swift
//  PetWithRxMVVM
//
//  Created by Artem Shilov on 08.08.2022.
//

import UIKit
import FirebaseAuth
import Firebase

final class SignUpViewController: UIViewController {
    
    //MARK: - Properties
    
    private lazy var signUpLabel: UILabel = {
        let signUpLabel = UILabel()
        signUpLabel.text = "Тут регистрируемся!"
        signUpLabel.font = .systemFont(ofSize: 28)
        signUpLabel.textColor = .black
        signUpLabel.textAlignment = .center
        signUpLabel.numberOfLines = 1
        return signUpLabel
    }()
    
    private lazy var nameTextField: UITextField = {
        let nameTextField = UITextField()
        nameTextField.textColor = .black
        nameTextField.backgroundColor = .white
        nameTextField.placeholder = "Ваше Имя"
        nameTextField.layer.cornerRadius = 5
        nameTextField.font = UIFont.systemFont(ofSize: 20)
        nameTextField.clearButtonMode = .whileEditing
        return nameTextField
    }()
    
    private lazy var lastNameTextField: UITextField = {
        let lastNameTextField = UITextField()
        lastNameTextField.textColor = .black
        lastNameTextField.backgroundColor = .white
        lastNameTextField.placeholder = "Ваша Фамилия"
        lastNameTextField.layer.cornerRadius = 5
        lastNameTextField.font = UIFont.systemFont(ofSize: 20)
        lastNameTextField.clearButtonMode = .whileEditing
        return lastNameTextField
    }()
    
    private lazy var emailTextField: UITextField = {
        let emailTextField = UITextField()
        emailTextField.textColor = .black
        emailTextField.backgroundColor = .white
        emailTextField.placeholder = "Ваш Email"
        emailTextField.layer.cornerRadius = 5
        emailTextField.font = UIFont.systemFont(ofSize: 20)
        emailTextField.clearButtonMode = .whileEditing
        return emailTextField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let passwordTextField = UITextField()
        passwordTextField.textColor = .black
        passwordTextField.backgroundColor = .white
        passwordTextField.placeholder = "Ваш пароль"
        passwordTextField.layer.cornerRadius = 5
        passwordTextField.font = UIFont.systemFont(ofSize: 20)
        passwordTextField.clearButtonMode = .whileEditing
        return passwordTextField
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
    
    private lazy var errorLabel: UILabel = {
        let errorLabel = UILabel()
        errorLabel.font = UIFont.systemFont(ofSize: 20)
        errorLabel.text = "Некорректные данные"
        errorLabel.numberOfLines = 0
        errorLabel.textAlignment = .center
        errorLabel.textColor = .clear
        return errorLabel
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.isHidden = true
        return activityIndicator
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 30
        return stackView
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSignUpViewController()
    }
    
    //MARK: - Methods
    
    private func configureSignUpViewController() {
        view.backgroundColor = .milfPink
        configureSignUpLabel()
        configureStackView()
        configureErrorLabel()
        configureDismissButton()
        configureRegisterButton()
        cofigureActivityIndicator()
    }
    
    private func configureSignUpLabel() {
        view.addSubview(signUpLabel)
        signUpLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(50)
            make.left.right.equalToSuperview().inset(50)
        }
    }
    
    private func configureStackView() {
        view.addSubview(stackView)
        
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
        view.addSubview(errorLabel)
        errorLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(stackView.snp.bottom).offset(50)
        }
    }
    
    private func configureDismissButton() {
        view.addSubview(dismissButton)
        dismissButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(60)
            make.width.equalTo(250)
            make.height.equalTo(50)
        }
    }
    
    private func configureRegisterButton() {
        view.addSubview(registerButton)
        registerButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(dismissButton.snp.top).offset(-15)
            make.width.equalTo(250)
            make.height.equalTo(50)
        }
    }
    
    private func cofigureActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(registerButton.snp.top).offset(-20)
        }
    }
    
    private func validateFields() -> String? {
        if nameTextField.text == "" ||
            lastNameTextField.text == "" ||
            emailTextField.text == "" ||
            passwordTextField.text == "" {
            return "Заполните все поля"
        }
        
        guard let cleanName = nameTextField.text, let cleanLastName = lastNameTextField.text else { return nil }
        if Utilities.isNameValid(cleanName) == false || Utilities.isNameValid(cleanLastName) == false {
            return "Некорректные имя или фамилия"
        }
        
        guard let cleanEmail = emailTextField.text else { return nil }
        if Utilities.isEmailValid(cleanEmail) == false {
            return "Некорректный email"
        }
        
        guard let cleanPassword = passwordTextField.text else { return nil }
        if Utilities.isPasswordValid(cleanPassword) == false {
            return "Пароль должен содержать минимум 8 символов, включая числа и спец символы"
        }
        
        return nil
    }
    
    private func showError(_ message: String) {
        errorLabel.textColor = .red
        errorLabel.text = message
    }
    
    @objc
    func registerButtonClicked() {
        let error = validateFields()
        if error != nil {
            guard let error = error else { return }
            showError(error)
        } else {
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
            
            let name = nameTextField.text
            let lastName = lastNameTextField.text
            let email = emailTextField.text
            let password = passwordTextField.text
            
            Auth.auth().createUser(withEmail: email ?? "", password: password ?? "") { [weak self] result, err in
                guard let self = self else { return }
                if err != nil {
                    self.showError("Ошибка создания пользователя")
                } else {
                    let database = Firestore.firestore()
                    database.collection("users").addDocument(data: [
                        "firstName":name ?? "",
                        "lastName":lastName ?? "",
                        "uid":result?.user.uid ?? ""]) { error in
                            if error != nil {
                                self.showError("Ошибка сохранения данных")
                            }
                        }
                    self.errorLabel.textColor = .green
                    self.errorLabel.text = "Регистрация прошла успешно"
                    self.activityIndicator.isHidden = true
                    self.activityIndicator.stopAnimating()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        self.dismiss(animated: true)
                    }
                }
            }
        }
    }
    
    @objc
    func dismissButtonClicked() {
        self.dismiss(animated: true)
    }
}
