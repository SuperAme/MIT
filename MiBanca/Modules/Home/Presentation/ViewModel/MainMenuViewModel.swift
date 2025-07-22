//
//  MainMenuViewModel.swift
//  MiBanca
//
//  Created by Américo MQ on 21/07/25.
//

import Foundation
import Combine

class MainMenuViewModel: ObservableObject {
    @Published var isLoggedOut = false
    private let authUseCase: AuthUseCase

    init(authUseCase: AuthUseCase = AuthRepository()) {
        self.authUseCase = authUseCase
    }

    func logout() {
        authUseCase.logout()
        isLoggedOut = true
    }
}
