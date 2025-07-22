//
//  Helpers.swift
//  MiBanca
//
//  Created by Américo MQ on 21/07/25.
//

import Foundation

func isValidCardNumber(_ number: String) -> Bool {
    let digitsOnly = number.replacingOccurrences(of: " ", with: "")
    return digitsOnly.count == 16 && digitsOnly.allSatisfy { $0.isNumber }
}
