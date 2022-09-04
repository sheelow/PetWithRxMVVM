//
//  SingUpViewModel.swift
//  PetWithRxMVVM
//
//  Created by Artem Shilov on 01.09.2022.
//

import Foundation
import RxSwift
import RxCocoa

protocol SignUpViewModelProtocol {
    var regState: PublishSubject<FirebaseManager.RegistationState> { get }
    func register(name: String, lastName: String, email: String, password: String)
}

final class SignUpViewModel: SignUpViewModelProtocol {

    //MARK: - Properties

    var regState = PublishSubject<FirebaseManager.RegistationState>()

    private var firebaseManager: FirebaseManagerProtocol

    //MARK: - Init

    init(firebaseManager: FirebaseManagerProtocol) {
        self.firebaseManager = firebaseManager
    }

    //MARK: - Methods

    func register(name: String, lastName: String, email: String, password: String) {
        firebaseManager.createUser(name: name, lastName: lastName, email: email, password: password) { [weak self] result in
            guard let self = self else { return }
            self.regState.onNext(result)
        }
    }
}
