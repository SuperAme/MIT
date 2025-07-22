//
//  CardsViewModel.swift
//  MiBanca
//
//  Created by Américo MQ on 21/07/25.
//

import Combine

class CardsViewModel: ObservableObject {
    @Published var cards: [Card] = []
    private let useCase: CardsUseCase

    init(useCase: CardsUseCase = CardRepository()) {
        self.useCase = useCase
        loadCards()
    }

    func loadCards() {
        cards = useCase.getCards()
    }

    func addCard(_ card: Card) {
        useCase.addCard(card)
        loadCards()
    }
}

