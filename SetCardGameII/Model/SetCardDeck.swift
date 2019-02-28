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
        for symbol in SetCard.Symbol.allCases {
            for count in SetCard.Count.allCases {
                for shade in SetCard.Shading.allCases {
                    for color in SetCard.Filling.allCases {
                        cards.append(SetCard.init(symbol: symbol, count: count, shade: shade, color: color))
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
