//
//  AuthError.swift
//  MiBanca
//
//  Created by Américo MQ on 21/07/25.
//

import Foundation

enum AuthError: Error, LocalizedError {
    case userAlreadyExists
    case invalidCredentials
    case invalidPassword
    case emptyFields

    var errorDescription: String? {
        switch self {
        case .userAlreadyExists: return "El usuario ya existe"
        case .invalidCredentials: return "Credenciales inválidas"
        case .invalidPassword: return "Contraseña inválida (mínimo 6 caracteres alfanuméricos)"
        case .emptyFields: return "Usuario y contraseña requeridos"
        }
    }
}
