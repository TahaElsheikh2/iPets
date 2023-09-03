//
//  StringExtension.swift
//  iPets
//
//  Created by Taha on 28/08/2023.
//

import Foundation

extension String {
    func isValidEmail() -> Bool {

        let emailRegex = "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: self)
    }
    
    func isValidPassword() -> Bool {
        let minLength = 8
        let uppercaseLetterRegex = ".*[A-Z]+.*"
        let lowercaseLetterRegex = ".*[a-z]+.*"
        let digitRegex = ".*[0-9]+.*"
        
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*\(uppercaseLetterRegex))(?=.*\(lowercaseLetterRegex))(?=.*\(digitRegex)).{\(minLength),}$")
        return passwordTest.evaluate(with: self)
    }
    
    func isValidEgyptMobileNumber() -> Bool {
        // Regular expression pattern for validating Egypt mobile numbers
        let mobileNumberRegex = "^01[0|1|2|5]{1}[0-9]{8}$"
        let mobileNumberPredicate = NSPredicate(format: "SELF MATCHES %@", mobileNumberRegex)
        return mobileNumberPredicate.evaluate(with: self)
    }
}
