//
//  RegisterCardView.swift
//  MiBanca
//
//  Created by Américo MQ on 21/07/25.
//

import SwiftUI

struct RegisterCardView: View {
    @State private var name = ""
    @State private var number = ""
    @State private var expirationDate = ""

    var onSave: (Card) -> Void

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Datos de la tarjeta")) {
                    TextField("Nombre del tarjetahabiente", text: $name)
                    CardNumberTextField(cardNumber: $number, title: "Numero de tarjeta")
                    TextField("Fecha de expiración (MM/AA)", text: $expirationDate)
                }
            }
            .navigationTitle("Registrar Tarjeta")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Guardar") {
                        let newCard = Card(nombreTarjetahabiente: name,
                                                numeroTarjeta: number,
                                                fechaExpiracion: expirationDate)
                        onSave(newCard)
                        presentationMode.wrappedValue.dismiss()
                    }
                    .disabled(name.isEmpty || number.isEmpty || expirationDate.isEmpty)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}

