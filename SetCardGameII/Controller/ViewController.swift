//
//  ViewController.swift
//  SetCardGame
//
//  Created by Ilya Abdullin on 08/02/2019.
//  Copyright © 2019 Ilya Abdullin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var game: SetGame?
    
    @IBOutlet weak var plus3CardButton: UIButton!
    
    @IBOutlet weak var setsNumberLabel: UILabel!
    
    var setsNumber: Int = 0 {
        didSet {
            setsNumberLabel.text = "\(setsNumber) set" + (setsNumber != 1 ? "s" : "")
        }
    }
    
    @IBOutlet weak var scoreGameLabel: UILabel!
    
    var scoreGame: Int = 0 {
        didSet {
            scoreGameLabel.text = "\(scoreGame)"
        }
    }
    
    @IBOutlet weak var gridView: GridView!
    
//    var allChosenCards: [SetCardView] {
//        return cardViews.filter{$0.card?.isChoosing == true}
//    }
    
//    var cardsOnTable: [SetCard] {
//        return cardViews.filter {$0.card != nil} .map { $0.card! }
//    }
    
    @IBAction func touchCard(_ sender: UITapGestureRecognizer) {
        if let chosenCard = sender.view as? SetCardView {
            chosenCard.isSelected = !chosenCard.isSelected
        }
    }
    
    @IBAction func chooseCard(_ chosenCard: SetCardView) {
//        UIViewPropertyAnimator.runningPropertyAnimator( //select new card with animation
//            withDuration: 0.3,
//            delay: 0,
//            options: [],
//            animations: {
//
//                chosenCard.card?.isChoosing = !(chosenCard.card?.isChoosing)!
//                if (chosenCard.card?.isChoosing)! {
//                    chosenCard.transform = CGAffineTransform.identity.scaledBy(x: 1.2, y: 1.2)
//                }
//                else {
//                    chosenCard.transform = CGAffineTransform.identity.scaledBy(x: 1, y: 1)
//                }
//            },
//            completion: { position in
//                if self.allChosenCards.count >= 3 { // check for set
//                    let cardsForAnimation = self.allChosenCards
//
//                    if self.game!.isSet(cardsForAnimation[0].card!, cardsForAnimation[1].card!, cardsForAnimation[2].card!) {
//                        if self.plus3CardButton.isEnabled == false {
//                            self.plus3CardButton.isEnabled = true
//                        }
//
//                        UIViewPropertyAnimator.runningPropertyAnimator(
//                            withDuration: 0.3,
//                            delay: 0.0,
//                            animations: {
//                                cardsForAnimation.forEach {
//                                    $0.transform = CGAffineTransform.identity.scaledBy(x: 1.5, y: 1.5)
//                                }
//                            },
//                            completion: { position in
//                                UIViewPropertyAnimator.runningPropertyAnimator(
//                                    withDuration: 0.3,
//                                    delay: 0.0,
//                                    options: [],
//                                    animations: {
//                                        cardsForAnimation.forEach {
//                                            $0.transform = CGAffineTransform.identity.scaledBy(x: 0.1, y: 0.1)
//                                        }
//                                    },
//                                    completion: { position in
//                                        cardsForAnimation.forEach {
//                                            $0.transform = .identity
//                                        }
//                                        cardsForAnimation.forEach {
//                                            $0.card = nil
//                                        }
//
//                                        self.setsNumber = self.game!.getSetsNumber(cardsForSet: self.cardsOnTable)
//                                    }
//                                )
//                            }
//                        )
//                    }
//                    else { // wrong set - turn on shake animation
//                        let cardsForAnimation = self.allChosenCards
//
//                        for card in cardsForAnimation {
//                            card.shake(duration: 0.3)
//                        }
//
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4, execute: {
//                            for card in cardsForAnimation {
//                                card.transform = .identity
//                                card.card?.isChoosing = false
//                            }
//
//                            self.setsNumber = self.game!.getSetsNumber(cardsForSet: self.cardsOnTable)
//                        })
//                    }
//
//                    self.scoreGame = self.game!.score
//                }
//            }
//        )
    }
    
    @IBAction func add3MoreCard(_ sender: UIButton) {
//        if sender.isEnabled {
//            for _ in 0..<3 {
//                addNextCardToFreeButton()
//            }
//
//            setsNumber = game!.getSetsNumber(cardsForSet: cardsOnTable)
//        }
//
//        if cardsOnTable.count >= 24 {
//            sender.isEnabled = false
//        }
//
//        sender.setTitle("+3 card/\(game?.deck.cards.count ?? 0)", for: .normal)
    }
    

    
    @objc
    private func tapCard(recognizedBy recognizer: UITapGestureRecognizer) {
        switch recognizer.state {
        case .ended:
            if let cardView = recognizer.view! as? SetCardView {
                
                //game.chooseCard(at: boardView.cardViews.index(of: cardView)!)
            }
        default:
            break
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
//        for button in cardViews.filter({$0.isHidden == false}) {
//            button.setNeedsDisplay()
//        }
    }
    
}

//drawing cards logic
extension ViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        runNewGame()
    }
    
    @IBAction func runNewGame() {
        game = SetGame()
        
        for _ in 0..<game!.cardsAmountOnStartGame {
            addNextCardToGrid()
        }
        
        //setsNumber = game!.getSetsNumber(cardsForSet: gridView!.cardViews.map{$0.card?})
    }

    private func addNextCardToGrid() {
        let cardView = SetCardView()
        cardView.card = game!.getNextCard()
        addTapGestureRecognizer(for: cardView)
        gridView.cardViews.append(cardView)
    }
    
    private func addTapGestureRecognizer(for cardView: SetCardView) {
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(tapCard(recognizedBy: )))
        tap.numberOfTapsRequired = 1
        tap.numberOfTouchesRequired = 1
        cardView.addGestureRecognizer(tap)
    }
    
    @IBAction func swipeDown(_ sender: UISwipeGestureRecognizer) {
        if game!.deck.cards.count > 0 {
            for _ in 1...3 {
                addNextCardToGrid()
            }
        }
    }
}

//shake animation for UIView
extension UIView {
    func shake(duration: CFTimeInterval) {
        let translation = CAKeyframeAnimation(keyPath: "transform.translation.x");
        translation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        translation.values = [-5, 5, -5, 5, -3, 3, -2, 2, 0]
        
        let rotation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        rotation.values = [-5, 5, -5, 5, -3, 3, -2, 2, 0].map {
            ( degrees: Double) -> Double in
            let radians: Double = (.pi * degrees) / 180.0
            return radians
        }
        
        let shakeGroup: CAAnimationGroup = CAAnimationGroup()
        shakeGroup.animations = [translation, rotation]
        shakeGroup.duration = duration
        self.layer.add(shakeGroup, forKey: "shakeIt")
    }
}
