//
//  MovementsView.swift
//  MiBanca
//
//  Created by Américo MQ on 21/07/25.
//

import SwiftUI

struct MovementsView: View {
    @StateObject var viewModel = MovementsViewModel()

    var body: some View {
        List {
            ForEach(viewModel.payments) { payment in
                VStack(alignment: .leading, spacing: 6) {
                    Text("De: \(payment.originCard)")
                    Text("A: \(payment.destinyCard)")
                    Text("Destinatario: \(payment.destinataryName)")
                    Text("Motivo: \(payment.concept)")
                    Text("Fecha: \(viewModel.formatDate(payment.date))")
                    Text("Ubicación: \(viewModel.addressForPayment(payment))")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .padding(.vertical, 6)
            }
        }
        .navigationTitle("Mis Movimientos")
    }
}

