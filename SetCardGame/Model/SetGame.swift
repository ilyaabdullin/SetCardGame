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
    
    private func getThirdCardForSet(card1: SetCard, card2: SetCard) -> SetCard {
        func getSymbol(_ symbol1: SetCard.Symbol, _ symbol2: SetCard.Symbol) -> SetCard.Symbol {
            switch (symbol1, symbol2) {
            case (.circle, .triangle), (.triangle, .circle):
                return .square
            case (.circle, .square), (.square, .circle):
                return .triangle
            case (.triangle, .square), (.square, .triangle):
                return .circle
            default:
                return symbol1
            }
        }
        
        func getNumber(_ number1: SetCard.Number, _ number2: SetCard.Number) -> SetCard.Number {
            if number1 == number2 {
                return number1
            }
            
            return SetCard.Number(rawValue: (SetCard.Number.one.rawValue + SetCard.Number.two.rawValue + SetCard.Number.three.rawValue) - number1.rawValue - number2.rawValue)!
        }
        
        func getShade(_ shade1: SetCard.Shading, _ shade2: SetCard.Shading) -> SetCard.Shading {
            if shade1 == shade2 {
                return shade1
            }
            
            return SetCard.Shading(rawValue: (SetCard.Shading.solid.rawValue + SetCard.Shading.striped.rawValue + SetCard.Shading.open.rawValue) - shade1.rawValue - shade2.rawValue)!
        }
        
        func getColor(_ color1: SetCard.Filling, _ color2: SetCard.Filling) -> SetCard.Filling {
            if color1 == color2 {
                return color1
            }
            
            return SetCard.Filling(rawValue: (SetCard.Filling.green.rawValue + SetCard.Filling.purple.rawValue + SetCard.Filling.red.rawValue) - color1.rawValue - color2.rawValue)!
        }
        
        let symbol = getSymbol(card1.symbol, card2.symbol)
        let number = getNumber(card1.number, card2.number)
        let shade = getShade(card1.shade, card2.shade)
        let color = getColor(card1.color, card2.color)
        
        return SetCard(symbol: symbol, number: number, shade: shade, color: color)
    }
    
    func getSetsNumber(cardsForSet: [SetCard]) -> Int {
        var setsNumber = 0
        
        var cards = cardsForSet
        while cards.count > 0 {
            let card1 = cards.remove(at: 0)
            for card2 in cards {
                let cardForSet = getThirdCardForSet(card1: card1, card2: card2)
                if cards.filter({$0 == cardForSet && $0 != card2}).count > 0 {
                    setsNumber += 1
                    break
                }
            }
        }
        
        return setsNumber
    }
}
