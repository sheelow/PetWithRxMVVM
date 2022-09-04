//
//  Utilities.swift
//  PetWithRxMVVM
//
//  Created by Artem Shilov on 10.08.2022.
//

import Foundation

final class Utilities {

    static func isNameValid(_ name: String) -> Bool {
        let nameTest = NSPredicate(format: "SELF MATCHES %@", "[А-Яа-яA-Za-z]{2,}")
        return nameTest.evaluate(with: name)
    }

    static func isEmailValid(_ email: String) -> Bool {
        let emailTest = NSPredicate(format:"SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
        return emailTest.evaluate(with: email)
    }

    static func isPasswordValid(_ password: String) -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
}
