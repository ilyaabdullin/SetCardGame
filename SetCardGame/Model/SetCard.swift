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
    let number: Number
    let shading: Shading
    let color: Filling
    
    enum Symbol: String {
        case triangle = "▲"
        case square = "■"
        case circle = "●"
        
        static var all = [Symbol.triangle, .square, .circle]
    }
    
    enum Number: Int {
        case one = 1, two, three
        
        static var all = [Number.one, .two, .three]
    }
    
    enum Shading: Int {
        case solid = 1, striped, open
        
        static var all = [Shading.solid, .striped, .open]
    }
    
    enum Filling: Int {
        case red = 0xFF3B30
        case green = 0x4CD964
        case purple = 0x5856D6
        
        static var all = [Filling.red, .green, .purple]
    }
}
