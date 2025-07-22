//
//  CardRepository.swift
//  MiBanca
//
//  Created by Américo MQ on 21/07/25.
//

import Foundation

class CardRepository: CardsUseCase {
    private let key = "mis_tarjetas"

    func getCards() -> [Card] {
        guard let data = UserDefaults.standard.data(forKey: key),
              let tarjetas = try? JSONDecoder().decode([Card].self, from: data) else {
            return []
        }
        return tarjetas
    }

    func addCard(_ card: Card) {
        var cards = getCards()
        cards.append(card)
        if let data = try? JSONEncoder().encode(cards) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }
}
