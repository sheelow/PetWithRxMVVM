//
//  SingUpViewModel.swift
//  PetWithRxMVVM
//
//  Created by Artem Shilov on 01.09.2022.
//

import Foundation
import RxSwift
import RxCocoa

//MARK: - SignUpViewModelProtocol

protocol SignUpViewModelProtocol {
    
}

//MARK: - LoginViewModel

final class SignUpViewModel: SignUpViewModelProtocol {

    //MARK: - Properties

    private var firebaseManager: FirebaseManagerProtocol

    //MARK: - Init

    init(firebaseManager: FirebaseManagerProtocol) {
        self.firebaseManager = firebaseManager
    }

    //MARK: - Methods
    
    
    
}
