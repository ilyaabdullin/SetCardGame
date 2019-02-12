//
//  ViewController.swift
//  SetCardGame
//
//  Created by Ilya Abdullin on 08/02/2019.
//  Copyright © 2019 Ilya Abdullin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var game = SetGame()

    @IBOutlet var cardViews: [SetCardButtonView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for button in cardViews {
            button.card = nil
        }
        
        for card in game.cardsOnTable {
            let freeButtonForCard = cardViews.filter{$0.card == nil}

            if freeButtonForCard.count > 0 {
                let buttonForCard = freeButtonForCard[Int.random(in: 0..<freeButtonForCard.count)]
                buttonForCard.card = card
            }
        }
        
        //updateViewFromModel()
    }
    
    func updateViewFromModel() {
        for cardView in cardViews {
            if cardView.card == nil {
                cardView.isStoryboardView = false
            }
        }
    }

}
