//
//  MyCardsView.swift
//  MiBanca
//
//  Created by Américo MQ on 21/07/25.
//

import SwiftUI

struct MyCardsView: View {
    @StateObject var viewModel = CardsViewModel()
    @State private var showForm = false

    var body: some View {
        List {
            ForEach(viewModel.cards) { card in
                VStack(alignment: .leading) {
                    Text(card.nombreTarjetahabiente)
                        .font(.headline)
                    Text(card.numeroTarjeta)
                        .font(.subheadline)
                    Text("Expira: \(card.fechaExpiracion)")
                        .font(.subheadline)
                }
                .padding(.vertical, 8)
            }
        }
        .navigationTitle("Mis Tarjetas")
        .toolbar {
            Button(action: {
                showForm = true
            }) {
                Image(systemName: "plus")
            }
        }
        .sheet(isPresented: $showForm) {
            NavigationStack {
                RegisterCardView { newCard in
                    viewModel.addCard(newCard)
                    showForm = false
                }
            }
        }

    }
}

