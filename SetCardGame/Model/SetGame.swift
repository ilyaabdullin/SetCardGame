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
}
