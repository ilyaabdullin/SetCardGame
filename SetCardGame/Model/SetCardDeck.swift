//
//  SetCardDeck.swift
//  SetCardGame
//
//  Created by Ilya Abdullin on 11/02/2019.
//  Copyright © 2019 Ilya Abdullin. All rights reserved.
//

import Foundation

struct SetCardDeck {
    private(set) var cards = [SetCard]()
    
    init() {
        for symbol in SetCard.Symbol.all {
            for number in SetCard.Number.all {
                for shade in SetCard.Shading.all {
                    for color in SetCard.Filling.all {
                        cards.append(SetCard.init(symbol: symbol, number: number, shade: shade, color: color))
                    }
                }
            }
        }
        
        cards.shuffle()
    }
    
    mutating func draw() -> SetCard? {
        return cards.count > 0 ? cards.remove(at: Int.random(in: 0..<cards.count)) : nil
    }
    
}
