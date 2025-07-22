//
//  PaymentsViewModel.swift
//  MiBanca
//
//  Created by Américo MQ on 21/07/25.
//

import Foundation

class PaymentViewModel: ObservableObject {
    @Published var availableCards: [Card] = []
    @Published var selectedCard: Card?
    @Published var destinyCard: String = ""
    @Published var recipientName: String = ""
    @Published var motivo: String = ""
    @Published var madePayment: Bool = false
    @Published var errorMessage: String?

    private let tarjetasUseCase: CardsUseCase
    private let pagosUseCase: PaymentsUseCase

    init(tarjetasUseCase: CardsUseCase = CardRepository(),
         pagosUseCase: PaymentsUseCase = PaymentsRepository()) {
        self.tarjetasUseCase = tarjetasUseCase
        self.pagosUseCase = pagosUseCase
        cargarTarjetas()
    }

    func cargarTarjetas() {
        availableCards = tarjetasUseCase.getCards()
        if selectedCard == nil && !availableCards.isEmpty {
            selectedCard = availableCards.first
        }
    }

    func realizarPago() {
        guard let origin = selectedCard else {
            errorMessage = "Selecciona una tarjeta"
            return
        }

        guard !destinyCard.isEmpty, !recipientName.isEmpty, !motivo.isEmpty else {
            errorMessage = "Completa todos los campos"
            return
        }

        let newPayment = Payment(
            originCard: origin.numeroTarjeta,
            destinyCard: destinyCard,
            destinataryName: recipientName,
            concept: motivo,
            date: Date()
        )

        pagosUseCase.savePayment(newPayment)
        cleanFields()
        madePayment = true
    }

    private func cleanFields() {
        destinyCard = ""
        recipientName = ""
        motivo = ""
        errorMessage = nil
    }
}

