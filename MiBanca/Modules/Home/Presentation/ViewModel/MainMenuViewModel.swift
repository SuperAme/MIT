//
//  MainMenuViewModel.swift
//  MiBanca
//
//  Created by Américo MQ on 21/07/25.
//

import Foundation
import Combine

class MainMenuViewModel: ObservableObject {
    private let authUseCase: AuthUseCase
    private let session: SessionManager

    init(authUseCase: AuthUseCase = AuthRepository(), session: SessionManager) {
        self.authUseCase = authUseCase
        self.session = session
    }

    func logout() {
        authUseCase.logout()
        session.isLoggedIn = false
    }
}
