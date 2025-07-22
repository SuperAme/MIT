//
//  PaymentsViewModel.swift
//  MiBanca
//
//  Created by Américo MQ on 21/07/25.
//

import Foundation
import CoreLocation

class PaymentViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var availableCards: [Card] = []
    @Published var selectedCard: Card?
    @Published var destinyCard: String = ""
    @Published var recipientName: String = ""
    @Published var motivo: String = ""
    @Published var madePayment: Bool = false
    @Published var errorMessage: String?

    private let tarjetasUseCase: CardsUseCase
    private let pagosUseCase: PaymentsUseCase
    private var locationManager: CLLocationManager
    private var actualLocation: CLLocation?

    init(tarjetasUseCase: CardsUseCase = CardRepository(),
         pagosUseCase: PaymentsUseCase = PaymentsRepository()) {
        self.tarjetasUseCase = tarjetasUseCase
        self.pagosUseCase = pagosUseCase
        self.locationManager = CLLocationManager()
        super.init()
        self.locationManager.delegate = self
        loadCards()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        actualLocation = locations.last
    }

    func loadCards() {
        availableCards = tarjetasUseCase.getCards()
        if selectedCard == nil && !availableCards.isEmpty {
            selectedCard = availableCards.first
        }
    }

    func makePayment() {
        guard let origin = selectedCard else {
            errorMessage = "Selecciona una tarjeta"
            return
        }

        guard isValidCardNumber(destinyCard) else {
            print("Número de tarjeta destino inválido. Debe tener 16 dígitos.")
            return
        }

        guard !destinyCard.isEmpty, !recipientName.isEmpty, !motivo.isEmpty else {
            errorMessage = "Completa todos los campos"
            return
        }

        let paymentLocation = actualLocation.map {
            PaymentLocation(latitude: $0.coordinate.latitude, longitude: $0.coordinate.longitude)
        }

        let newPayment = Payment(
            originCard: origin.numeroTarjeta,
            destinyCard: destinyCard,
            destinataryName: recipientName,
            concept: motivo,
            date: Date(),
            location: paymentLocation
        )

        pagosUseCase.savePayment(newPayment)
        cleanFields()
        madePayment = true
    }

    func getLocationPermissions() {
        locationManager.delegate = self
        locationManagerDidChangeAuthorization(locationManager)
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let status = manager.authorizationStatus
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            manager.startUpdatingLocation()
        case .denied, .restricted:
            print("Permiso de ubicación denegado")
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        @unknown default:
            break
        }
    }

    private func cleanFields() {
        destinyCard = ""
        recipientName = ""
        motivo = ""
        errorMessage = nil
    }
}

