//
//  Payment.swift
//  MiBanca
//
//  Created by Américo MQ on 21/07/25.
//

import Foundation

struct Payment: Identifiable, Codable {
    let id = UUID()
    let originCard: String
    let destinyCard: String
    let destinataryName: String
    let concept: String
    let date: Date
}
