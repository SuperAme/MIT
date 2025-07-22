//
//  AuthUseCase.swift
//  MiBanca
//
//  Created by Américo MQ on 21/07/25.
//

import Foundation

protocol AuthUseCase {
    func login(user: String, password: String) throws
    func register(user: String, password: String) throws
    func isLoggedIn() -> Bool
    func logout()
    func getCurrentUser() -> String?
}
