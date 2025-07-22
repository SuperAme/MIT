//
//  MovementsViewModel.swift
//  MiBanca
//
//  Created by Américo MQ on 21/07/25.
//

import Foundation
import CoreLocation

class MovementsViewModel: ObservableObject {
    @Published var payments: [Payment] = []
    @Published var address: [UUID: String] = [:]

    private let paymentsUseCase: PaymentsUseCase
    private let geocoder = ReverseGeocoder()

    init(paymentsUseCase: PaymentsUseCase = PaymentsRepository()) {
        self.paymentsUseCase = paymentsUseCase
        getPayments()
    }

    func getPayments() {
        let madePayments = Array(paymentsUseCase.getPayments().reversed())
        payments = madePayments

        for payment in madePayments {
            if let location = payment.location {
                geocoder.getAddress(from: location) { [weak self] adress in
                    DispatchQueue.main.async {
                        self?.address[payment.id] = adress
                    }
                }
            } else {
                address[payment.id] = "Ubicación no disponible"
            }
        }
    }

    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }

    func addressForPayment(_ payment: Payment) -> String {
        let dir = address[payment.id] ?? "Dirección no disponible"
        return address[payment.id] ?? "Buscando dirección..."
    }
}

