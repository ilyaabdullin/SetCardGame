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
    
    @IBOutlet weak var plus3CardButton: UIButton!
    
    var allChosenCards: [SetCardButtonView] {
        return cardViews.filter{$0.card?.isChoosing == true}
    }
    
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

    }

    @IBAction func chooseCard(_ chosenCard: SetCardButtonView) {
        //plus3CardButton.isEnabled = !plus3CardButton.isEnabled
        
        if allChosenCards.count > 2, chosenCard.card?.isChoosing == false {
            //снимаем выделение
            UIViewPropertyAnimator.runningPropertyAnimator(
                withDuration: 0.6,
                delay: 0,
                options: [], animations: {
                    self.allChosenCards.forEach {
                        if $0 !== chosenCard {
                            $0.transform = CGAffineTransform.identity.scaledBy(x: 1, y: 1)
                            $0.card?.isChoosing = false
                        }
                    }
            })
        }

        UIViewPropertyAnimator.runningPropertyAnimator(
            withDuration: 0.6,
            delay: 0,
            options: [], animations: {
                chosenCard.transform = CGAffineTransform.identity.scaledBy(x: 1.2, y: 1.2)
                chosenCard.card?.isChoosing = true
        })
    }
    
    @IBAction func add3MoreCard(_ sender: UIButton) {
        let freeButtonForCard = cardViews.filter{$0.card == nil}
        freeButtonForCard[Int.random(in: 0..<freeButtonForCard.count)].card = nil
    }
}
