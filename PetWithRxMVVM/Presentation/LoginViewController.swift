//
//  LoginViewController.swift
//  PetWithRxMVVM
//
//  Created by Artem Shilov on 08.08.2022.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    //MARK: - Properties

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

    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLoginViewController()
    }
    
    deinit {
        print("DEINIT")
    }
    
    //MARK: - Methods
    
    private func configureLoginViewController() {
        view.backgroundColor = UIColor(red: 171/255, green: 151/255, blue: 255/255, alpha: 1)
        configureLoginLabel()
        configureEmailTextField()
        configurePasswordTextField()
        configureDismissButton()
        configureLoginButton()
        configureErrorLabel()
        cofigureActivityIndicator()
    }

    private func configureLoginLabel() {
        view.addSubview(loginLabel)
        loginLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(50)
            make.left.right.equalToSuperview().inset(50)
        }
    }
    
    private func configureEmailTextField() {
        view.addSubview(emailTextField)
        emailTextField.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(loginLabel.snp.bottom).offset(100)
        }
    }
    
    private func configurePasswordTextField() {
        view.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(emailTextField.snp.bottom).offset(50)
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
    
    private func configureLoginButton() {
        view.addSubview(loginButton)
        loginButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(dismissButton.snp.top).offset(-15)
            make.width.equalTo(250)
            make.height.equalTo(50)
        }
    }
    
    private func configureErrorLabel() {
        view.addSubview(errorLabel)
        errorLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(passwordTextField.snp.bottom).offset(50)
        }
    }
    
    private func cofigureActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(loginButton.snp.top).offset(-20)
        }
    }
    
    @objc
    func dismissButtonClicked() {
        self.dismiss(animated: true)
    }
    
    @objc
    func loginButtonClicked(completion: () -> Void) {
        let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        Auth.auth().signIn(withEmail: email ?? "", password: password ?? "") { [weak self] result, error in
            
            guard let self = self else { return }
            if error != nil {
                self.errorLabel.textColor = .red
            } else {
                self.errorLabel.textColor = .green
                self.errorLabel.text = "Успешно"
                self.activityIndicator.isHidden = false
                self.activityIndicator.startAnimating()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    let mainTabBarController = MainTabBarController()
                    self.view.window?.rootViewController = mainTabBarController
                    self.view.window?.makeKeyAndVisible()
                }
            }
        }
//        let mainTabBarController = MainTabBarController()
//        mainTabBarController.modalPresentationStyle = .fullScreen
//        self.present(mainTabBarController, animated: true)
//        view.window?.rootViewController = mainTabBarController
//        view.window?.makeKeyAndVisible()
    }
}
