//
//  SessionManager.swift
//  MiBanca
//
//  Created by Américo MQ on 21/07/25.
//

import Foundation
import Combine

class SessionManager: ObservableObject {
    @Published var isLoggedIn: Bool = false

    init() {
        if let _ = KeychainService.shared.get(key: "userToken") {
            isLoggedIn = true
        }
    }

    func login(token: String) {
        let saved = KeychainService.shared.save(key: "userToken", value: token)
        if saved {
            isLoggedIn = true
        }
    }

    func logout() {
        KeychainService.shared.delete(key: "userToken")
        isLoggedIn = false
    }
}
