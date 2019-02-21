//
//  setCard.swift
//  SetCardGame
//
//  Created by Ilya Abdullin on 08/02/2019.
//  Copyright © 2019 Ilya Abdullin. All rights reserved.
//

import Foundation

struct SetCard: Equatable {
    let symbol: Symbol
    let count: Count
    let shade: Shading
    let color: Filling
    
    var isChoosing = false
    
    enum Symbol: Int, CaseIterable {
        case diamond = 1, oval, squiggle
    }
    
    enum Count: Int, CaseIterable {
        case one = 1, two, three
    }
    
    enum Shading: Int, CaseIterable {
        case solid = 1, striped, open
    }
    
    enum Filling: Int, CaseIterable {
        case red = 0xFF3B30
        case green = 0x4CD964
        case purple = 0x5856D6
    }
    
    init(symbol: SetCard.Symbol, number: SetCard.Count, shade: SetCard.Shading, color: SetCard.Filling) {
        self.symbol = symbol
        self.count = number
        self.shade = shade
        self.color = color
    }
}
