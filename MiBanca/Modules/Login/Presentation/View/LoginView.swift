//
//  LoginView.swift
//  MiBanca
//
//  Created by Américo MQ on 21/07/25.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var session: SessionManager
    @StateObject var viewModel = LoginViewModel(authUseCase: AuthRepository())

    var body: some View {
        VStack(spacing: 16) {
            TextField("Usuario", text: $viewModel.username)
                .frame(height: 24)
                .autocapitalization(.none)
                .modifier(RoundedTextFieldStyle())

            PasswordField(password: $viewModel.password)

            Button("Iniciar Sesión") {
                if viewModel.login() {
                    session.isLoggedIn = true
                }
            }

            Button("Crear Cuenta") {
                viewModel.register()
            }

            if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
            }
        }
        .padding()
        .navigationTitle("Login")
        .alert("Cuenta creada", isPresented: $viewModel.showSuccessAlert) {
            Button("Aceptar") {
                session.isLoggedIn = true
            }
        } message: {
            Text("Tu cuenta fue creada exitosamente.")
        }

    }
}


struct RoundedTextFieldStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.vertical, 10)
            .padding(.horizontal, 12)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray.opacity(0.6), lineWidth: 1)
            )
            .padding(.horizontal)
    }
}
