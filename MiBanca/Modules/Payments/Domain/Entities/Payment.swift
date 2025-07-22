//
//  Payment.swift
//  MiBanca
//
//  Created by Américo MQ on 21/07/25.
//

import Foundation
import CoreLocation

struct Payment: Identifiable, Codable {
    let id = UUID()
    let originCard: String
    let destinyCard: String
    let destinataryName: String
    let concept: String
    let date: Date
    let location: PaymentLocation?
}

struct PaymentLocation: Codable {
    let latitude: Double
    let longitude: Double
}
