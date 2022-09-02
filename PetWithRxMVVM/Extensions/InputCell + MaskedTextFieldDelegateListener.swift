////
////  InputCell + MaskedTextFieldDelegateListener.swift
////  PetWithRxMVVM
////
////  Created by Artem Shilov on 02.09.2022.
////
//
//import UIKit
//import InputMask
//
//extension UIView: MaskedTextFieldDelegateListener {
//
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        if textField.returnKeyType == .default {
//            handler?.selectNextInput(from: self)
//        }
//        return true
//    }
//
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        guard let input = input else { return }
//
//        if let di = input as? DateInput, let date = di.date {
//            let formatter = DateFormatter()
//            formatter.dateFormat = di.output
//
//            handler?.store(value: formatter.string(from: date), for: input.id)
//        } else if let pi = input as? PickerInput {
//            if pi.value?.isEmpty == false {
//                handler?.store(value: pi.value, for: input.id)
//            } else {
//                handler?.store(value: nil, for: input.id)
//            }
//        } else if input.listener != nil {
//            handler?.store(value: input.value, for: input.id)
//        } else {
//            handler?.store(value: textField.text?.trimmingCharacters(in: .whitespacesAndNewlines), for: input.id)
//        }
//
//        if input.error != nil { input.validate() }
//    }
//
//    func textField(_ textField: UITextField, didFillMandatoryCharacters complete: Bool, didExtractValue value: String) {
//        guard let input = input else { return }
//
//        if complete {
//            input.value = value
//            input.validate()
//        } else {
//            input.value = ""
//        }
//    }
//}
