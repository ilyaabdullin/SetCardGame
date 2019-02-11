//
//  SetGame.swift
//  SetCardGame
//
//  Created by Ilya Abdullin on 11/02/2019.
//  Copyright © 2019 Ilya Abdullin. All rights reserved.
//

import Foundation

class SetGame {
    
    private struct Constants {
        static let cardsAmountOnStartGame = 12
    }
    
    private var deck = SetCardDeck()
    
    private(set) var cardsOnTable = [SetCard]()
    
    init() {
        for _ in 1...Constants.cardsAmountOnStartGame {
            if let nextCard = deck.draw() {
                cardsOnTable.append(nextCard)
            }
        }
    }
    
    
}
