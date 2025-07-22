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

    @State private var internalText: String = ""

    var body: some View {
        TextField(title, text: $internalText)
            .keyboardType(.numberPad)
            .onChange(of: internalText) { newValue in
                let digitsOnly = newValue.filter { $0.isWholeNumber }
                let limitedDigits = String(digitsOnly.prefix(16))

                var formatted = ""
                for (index, char) in limitedDigits.enumerated() {
                    if index != 0 && index % 4 == 0 {
                        formatted.append(" ")
                    }
                    formatted.append(char)
                }

                if internalText != formatted {
                    internalText = formatted
                }
                cardNumber = formatted
            }
            .onAppear {
                internalText = cardNumber
            }
    }
}
