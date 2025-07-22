//
//  AuthRepository.swift
//  MiBanca
//
//  Created by Américo MQ on 21/07/25.
//

final class AuthRepository: AuthUseCase {
    private let storage: SecureStorage
    private let currentUserKey = "current_logged_user"

    init(storage: SecureStorage = KeychainService.shared) {
        self.storage = storage
    }

    func login(user: String, password: String) throws {
        guard !user.isEmpty, !password.isEmpty else {
            throw AuthError.emptyFields
        }

        guard let savedPassword = storage.get(key: user), savedPassword == password else {
            throw AuthError.invalidCredentials
        }

        _ = storage.save(key: currentUserKey, value: user)
    }

    func register(user: String, password: String) throws {
        guard !user.isEmpty, !password.isEmpty else {
            throw AuthError.emptyFields
        }

        guard password.count >= 6,
              password.range(of: "^[a-zA-Z0-9]+$", options: .regularExpression) != nil else {
            throw AuthError.invalidPassword
        }

        if storage.get(key: user) != nil {
            throw AuthError.userAlreadyExists
        }

        _ = storage.save(key: user, value: password)
        _ = storage.save(key: currentUserKey, value: user)
    }

    func isLoggedIn() -> Bool {
        return storage.get(key: currentUserKey) != nil
    }

    func logout() {
        storage.delete(key: currentUserKey)
    }

    func getCurrentUser() -> String? {
        return storage.get(key: currentUserKey)
    }
}


