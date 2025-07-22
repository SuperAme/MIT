//
//  PasswordField.swift
//  MiBanca
//
//  Created by Américo MQ on 21/07/25.
//

import SwiftUI

struct PasswordField: View {
    @Binding var password: String
    @State private var isPasswordVisible = false

    var body: some View {
        HStack(spacing: 0) {
            Group {
                if isPasswordVisible {
                    TextField("Contraseña", text: $password)
                        .autocapitalization(.none)
                } else {
                    SecureField("Contraseña", text: $password)
                        .autocapitalization(.none)
                }
            }
            .padding(.vertical, 10)
            .padding(.leading, 12)

            Button(action: {
                isPasswordVisible.toggle()
            }) {
                Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                    .foregroundColor(.gray)
//                    .frame(width: 44, height: 44) // tamaño fijo para botón táctil
            }
            .padding(.trailing, 8)
        }
        .frame(height: 24)
        .modifier(RoundedTextFieldStyle())
    }
}

