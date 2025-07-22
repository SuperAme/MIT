//
//  ReverseGeocoder.swift
//  MiBanca
//
//  Created by Américo MQ on 21/07/25.
//

import Foundation
import CoreLocation

class ReverseGeocoder {
    private let geocoder = CLGeocoder()

    func getAddress(from location: PaymentLocation, completion: @escaping (String) -> Void) {
        let location = CLLocation(latitude: location.latitude, longitude: location.longitude)

        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if let error = error {
                print("Error al geocodificar: \(error)")
                completion("Ubicación no disponible")
                return
            }

            if let placemark = placemarks?.first {
                let direccion = [
                    placemark.name,
                    placemark.locality,
                    placemark.administrativeArea,
                    placemark.country
                ]
                .compactMap { $0 }
                .joined(separator: ", ")

                completion(direccion)
            } else {
                completion("Ubicación no disponible")
            }
        }
    }
}

