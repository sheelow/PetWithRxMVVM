//
//  WelcomeView.swift
//  PetWithRxMVVM
//
//  Created by Artem Shilov on 01.09.2022.
//

import UIKit
import SnapKit

protocol WelcomeViewProtocol: AnyObject {
    func loginButtonClicked()
    func buttonCreateAccountClicked()
}

final class WelcomeView: UIView {

    //MARK: - Properties

    weak var delegate: WelcomeViewProtocol?

    private lazy var welcomeLabel: UILabel = {
        let welcomeLabel = UILabel()
        welcomeLabel.text = "Добро пожаловать!"
        welcomeLabel.font = .systemFont(ofSize: 28)
        welcomeLabel.textColor = .black
        welcomeLabel.textAlignment = .center
        welcomeLabel.numberOfLines = 1
        return welcomeLabel
    }()

    private lazy var loginButton: UIButton = {
        let loginButton = UIButton(type: .system)
        loginButton.backgroundColor = .milfPurple
        loginButton.setTitle("Войти", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.titleLabel?.font = .systemFont(ofSize: 18)
        loginButton.layer.cornerRadius = 20
        loginButton.addTarget(self, action: #selector(loginButtonClicked), for: .touchUpInside)
        return loginButton
    }()

    private lazy var createAccountButton: UIButton = {
        let createAccountButton = UIButton(type: .system)
        createAccountButton.backgroundColor = .milfPink
        createAccountButton.setTitle("Создать аккаунт", for: .normal)
        createAccountButton.setTitleColor(.white, for: .normal)
        createAccountButton.titleLabel?.font = .systemFont(ofSize: 18)
        createAccountButton.layer.cornerRadius = 20
        createAccountButton.addTarget(self, action: #selector(buttonCreateAccountClicked), for: .touchUpInside)
        return createAccountButton
    }()

    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureWelcomeView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Methods

    private func configureWelcomeView() {
        backgroundColor = .milkWhite
        configureWelcomeLabel()
        configureСreateAccountButton()
        configureLoginButton()
    }

    private func configureWelcomeLabel() {
        addSubview(welcomeLabel)
        welcomeLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(50)
            make.left.right.equalToSuperview().inset(50)
        }
    }

    private func configureСreateAccountButton() {
        addSubview(createAccountButton)
        createAccountButton.snp.makeConstraints { make in
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
            make.bottom.equalTo(createAccountButton.snp.top).offset(-15)
            make.width.equalTo(250)
            make.height.equalTo(50)
        }
    }

    @objc
    private func loginButtonClicked(_ sender: UIButton) {
        delegate?.loginButtonClicked()
    }

    @objc
    private func buttonCreateAccountClicked(_ sender: UIButton) {
        delegate?.buttonCreateAccountClicked()
    }
}
