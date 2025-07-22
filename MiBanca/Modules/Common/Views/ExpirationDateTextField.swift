//
//  ExpirationDateTextField.swift
//  MiBanca
//
//  Created by Américo MQ on 22/07/25.
//

import SwiftUI

struct ExpirationDateTextField: View {
    @Binding var expirationDate: String
    @State private var internalText: String = ""
    @State private var errorMessage: String?

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            TextField("Fecha de expiración (MM/AA)", text: $internalText)
                .keyboardType(.numberPad)
                .onChange(of: internalText) { newValue in
                    let digitsOnly = newValue.filter { $0.isWholeNumber }

                    let limited = String(digitsOnly.prefix(4))

                    var formatted = ""
                    for (index, char) in limited.enumerated() {
                        if index == 2 {
                            formatted.append("/")
                        }
                        formatted.append(char)
                    }

                    var isValid = true
                    errorMessage = nil

                    if formatted.count >= 2 {
                        let monthString = String(formatted.prefix(2))
                        if let month = Int(monthString), !(1...12).contains(month) {
                            errorMessage = "Mes inválido (debe ser 01 a 12)"
                            isValid = false
                        }
                    }

                    if formatted.count == 5 && isValid {
                        let components = formatted.split(separator: "/")
                        if components.count == 2,
                           let enteredMonth = Int(components[0]),
                           let enteredYear = Int(components[1]) {

                            let calendar = Calendar.current
                            let currentDate = Date()
                            let currentMonth = calendar.component(.month, from: currentDate)
                            let currentYear = calendar.component(.year, from: currentDate) % 100

                            if enteredYear < currentYear || (enteredYear == currentYear && enteredMonth < currentMonth) {
                                errorMessage = "La fecha ya ha pasado"
                                isValid = false
                            }
                        }
                    }
                    let final = String(formatted.prefix(5))
                    if internalText != final {
                        internalText = final
                    }

                    if isValid {
                        expirationDate = final
                    }
                }
                .onAppear {
                    internalText = expirationDate
                }

            if let error = errorMessage {
                Text(error)
                    .font(.caption)
                    .foregroundColor(.red)
            }
        }
    }
}
