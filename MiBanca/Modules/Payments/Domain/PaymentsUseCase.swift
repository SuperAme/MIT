//
//  PaymentsUseCase.swift
//  MiBanca
//
//  Created by Américo MQ on 21/07/25.
//

import Foundation

protocol PaymentsUseCase {
    func savePayment(_ payment: Payment)
    func getPayments() -> [Payment]
}
