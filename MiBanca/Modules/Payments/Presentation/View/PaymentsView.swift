//
//  PaymentsView.swift
//  MiBanca
//
//  Created by Américo MQ on 21/07/25.
//

import SwiftUI

struct PaymentView: View {
    @StateObject var viewModel = PaymentViewModel()

    var body: some View {
        Form {
            Section(header: Text("Tarjeta de origen")) {
                Picker("Seleccionar tarjeta", selection: $viewModel.selectedCard) {
                    ForEach(viewModel.availableCards) { card in
                        Text("\(card.numeroTarjeta)")
                            .tag(Optional(card))
                    }
                }
            }

            Section(header: Text("Datos del destinatario")) {
                TextField("Número de tarjeta destino", text: $viewModel.destinyCard)
                    .keyboardType(.numberPad)
                TextField("Nombre del destinatario", text: $viewModel.recipientName)
                TextField("Motivo del pago", text: $viewModel.motivo)
            }

            if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
            }

            Button("Realizar pago") {
                viewModel.realizarPago()
            }
        }
        .navigationTitle("Pagar")
        .alert(isPresented: $viewModel.madePayment) {
            Alert(title: Text("Pago realizado"), message: Text("El pago fue exitoso."), dismissButton: .default(Text("OK")))
        }
    }
}
