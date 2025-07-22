//
//  PaymentsRepository.swift
//  MiBanca
//
//  Created by Américo MQ on 21/07/25.
//

import Foundation

class PaymentsRepository: PaymentsUseCase {
    private let key = "historial_pagos"

    func savePayment(_ payment: Payment) {
        var payments = getPayments()
        payments.append(payment)
        if let data = try? JSONEncoder().encode(payments) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }

    func getPayments() -> [Payment] {
        guard let data = UserDefaults.standard.data(forKey: key),
              let payments = try? JSONDecoder().decode([Payment].self, from: data) else {
            return []
        }
        return payments
    }
}
