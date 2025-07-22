//
//  Card.swift
//  MiBanca
//
//  Created by Américo MQ on 21/07/25.
//

import Foundation

struct Card: Identifiable, Codable, Hashable {
    let id = UUID()
    var nombreTarjetahabiente: String
    var numeroTarjeta: String
    var fechaExpiracion: String
}
