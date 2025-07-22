//
//  CardsUseCase.swift
//  MiBanca
//
//  Created by Américo MQ on 21/07/25.
//

import Foundation

protocol CardsUseCase {
    func getCards() -> [Card]
    func addCard(_ card: Card)
}
