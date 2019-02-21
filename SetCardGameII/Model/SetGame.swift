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
    
    private(set) var score = 0
    
    func getNextCard() -> SetCard? {
        return deck.draw()
    }
    
    func isSet(_ card1: SetCard, _ card2: SetCard, _ card3: SetCard) -> Bool {
        let isSymbolSet =
            (card1.symbol == card2.symbol && card2.symbol == card3.symbol) ||
            (card1.symbol != card2.symbol && card1.symbol != card3.symbol && card2.symbol != card3.symbol)
        
        let isNumberSet =
            (card1.count == card2.count && card2.count == card3.count) ||
            (card1.count != card2.count && card1.count != card3.count && card2.count != card3.count)
        
        let isShadeSet =
            (card1.shade == card2.shade && card2.shade == card3.shade) ||
            (card1.shade != card2.shade && card1.shade != card3.shade && card2.shade != card3.shade)
        
        let isColcolor =
            (card1.color == card2.color && card2.color == card3.color) ||
            (card1.color != card2.color && card1.color != card3.color && card2.color != card3.color)
        
        let isSet = isSymbolSet && isNumberSet && isShadeSet && isColcolor
        
        if isSet {
            score += 3
        }
        else {
            score -= 3
        }
        
        return isSet
    }
    
    private func getThirdCardForSet(card1: SetCard, card2: SetCard) -> SetCard {
        func getSymbol(_ symbol1: SetCard.Symbol, _ symbol2: SetCard.Symbol) -> SetCard.Symbol {
            if symbol1 == symbol2 {
                return symbol1
            }
            
            return SetCard.Symbol(rawValue: (SetCard.Symbol.diamond.rawValue + SetCard.Symbol.oval.rawValue + SetCard.Symbol.squiggle.rawValue) - symbol1.rawValue - symbol2.rawValue)!
        }
        
        func getNumber(_ number1: SetCard.Count, _ number2: SetCard.Count) -> SetCard.Count {
            if number1 == number2 {
                return number1
            }
            
            return SetCard.Count(rawValue: (SetCard.Count.one.rawValue + SetCard.Count.two.rawValue + SetCard.Count.three.rawValue) - number1.rawValue - number2.rawValue)!
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
        let number = getNumber(card1.count, card2.count)
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
