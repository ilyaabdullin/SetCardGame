//
//  SetGame.swift
//  SetCardGame
//
//  Created by Ilya Abdullin on 11/02/2019.
//  Copyright © 2019 Ilya Abdullin. All rights reserved.
//

import Foundation

class SetGame {
    
    let cardsAmountOnStartGame = 12
    
    private(set) var deck = SetCardDeck()
    
    func getNextCard() -> SetCard? {
        return deck.draw()
    }
    
    func isSet(_ card1: SetCard, _ card2: SetCard, _ card3: SetCard) -> Bool {
        let isSymbolSet =
            (card1.symbol == card2.symbol && card2.symbol == card3.symbol) ||
            (card1.symbol != card2.symbol && card1.symbol != card3.symbol && card2.symbol != card3.symbol)
        
        let isNumberSet =
            (card1.number == card2.number && card2.number == card3.number) ||
            (card1.number != card2.number && card1.number != card3.number && card2.number != card3.number)
        
        let isShadeSet =
            (card1.shade == card2.shade && card2.shade == card3.shade) ||
            (card1.shade != card2.shade && card1.shade != card3.shade && card2.shade != card3.shade)
        
        let isColcolor =
            (card1.color == card2.color && card2.color == card3.color) ||
            (card1.color != card2.color && card1.color != card3.color && card2.color != card3.color)
        
        return isSymbolSet && isNumberSet && isShadeSet && isColcolor
    }
}
