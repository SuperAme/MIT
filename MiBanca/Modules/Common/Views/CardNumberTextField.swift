//
//  CardNumberTextField.swift
//  MiBanca
//
//  Created by Américo MQ on 21/07/25.
//

import SwiftUI

struct CardNumberTextField: View {
    @Binding var cardNumber: String
    var title: String

    var body: some View {
        TextField(title, text: Binding(
            get: { cardNumber },
            set: { newValue in
                let filtered = newValue.filter { $0.isNumber || $0 == " " }
                if filtered != cardNumber {
                    cardNumber = filtered
                }
            }
        ))
        .keyboardType(.numberPad)
    }
}
