//
//  LoginViewModel.swift
//  MiBanca
//
//  Created by Américo MQ on 21/07/25.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var username = ""
    @Published var password = ""
    @Published var errorMessage: String?
    @Published var loginSuccess = false
    @Published var showSuccessAlert = false

    private let authUseCase: AuthUseCase

    init(authUseCase: AuthUseCase) {
        self.authUseCase = authUseCase
        self.loginSuccess = authUseCase.isLoggedIn()
    }

    func login() -> Bool {
        do {
            try authUseCase.login(user: username, password: password)
            errorMessage = nil
            return true
        } catch {
            errorMessage = error.localizedDescription
            return false
        }
    }

    func register() {
        do {
            try authUseCase.register(user: username, password: password)
            errorMessage = nil
            showSuccessAlert = true
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
