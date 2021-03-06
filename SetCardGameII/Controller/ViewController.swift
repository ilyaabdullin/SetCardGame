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
    
    var allChosenCards: [SetCardView] {
        return gridView.cardViews.filter{$0.isSelected == true}
    }
    
    var cardsOnTable: [SetCard]? {
        return gridView.cardViews.map { $0.card! }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        runNewGame()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        for card in gridView.cardViews.filter({$0.card != nil}) {
            card.setNeedsDisplay()
        }
    }
}

//gameplay
extension ViewController {

    @IBAction func runNewGame() {
        game = SetGame()
        gridView.cardViews = [SetCardView]()
        plus3CardButton.isEnabled = true
        
        for _ in 0..<game!.cardsAmountOnStartGame {
            addNextCardToGrid()
        }
        
        plus3CardButton.setTitle("+3 card/\(game?.deck.cards.count ?? 0)", for: .normal)
        
        setsNumber = game!.getSetsNumber(cardsForSet: gridView!.cardViews.map({ $0.card! }))
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
            action: #selector(touchCard(recognizedBy: )))
        tap.numberOfTapsRequired = 1
        tap.numberOfTouchesRequired = 1
        cardView.addGestureRecognizer(tap)
    }
    
    @IBAction func swipeDown(_ sender: UISwipeGestureRecognizer) {
        add3MoreCard(plus3CardButton)
    }
    
    @IBAction func add3MoreCard(_ sender: UIButton) {
        if game!.deck.cards.count > 0 {
            for _ in 1...3 {
                addNextCardToGrid()
            }
        }
        
        if (game?.deck.cards.count)! == 0 {
            plus3CardButton.isEnabled = false
        }
        
        plus3CardButton.setTitle("+3 card/\(game?.deck.cards.count ?? 0)", for: .normal)
        setsNumber = game!.getSetsNumber(cardsForSet: gridView!.cardViews.map({ $0.card! }))
    }
    
    @objc private func touchCard(recognizedBy sender: UITapGestureRecognizer) {
        if let chosenCard = sender.view as? SetCardView {
            UIViewPropertyAnimator.runningPropertyAnimator( //select new card with animation
                withDuration: 0.3,
                delay: 0,
                options: [],
                animations: {
                    chosenCard.isSelected = !chosenCard.isSelected
                    
                    if chosenCard.isSelected {
                        chosenCard.transform = CGAffineTransform.identity.scaledBy(x: 1.2, y: 1.2)
                    }
                    else {
                        chosenCard.transform = CGAffineTransform.identity
                    }
                },
                completion: { position in
                    if self.allChosenCards.count >= 3 { // check for set
                        let cardsForAnimation = self.allChosenCards
                        
                        if self.game!.isSet(cardsForAnimation[0].card!, cardsForAnimation[1].card!, cardsForAnimation[2].card!) {
                            UIViewPropertyAnimator.runningPropertyAnimator(
                                withDuration: 0.3,
                                delay: 0.0,
                                animations: {
                                    cardsForAnimation.forEach {
                                        $0.transform = CGAffineTransform.identity.scaledBy(x: 0.1, y: 0.1)
                                    }
                                },
                                completion: { position in
                                    cardsForAnimation.forEach {
                                        self.gridView.cardViews.remove(at: self.gridView.cardViews.firstIndex(of: $0)!)
                                        $0.card = nil
                                    }
                                    self.setsNumber = self.game!.getSetsNumber(cardsForSet: self.gridView!.cardViews.map({ $0.card! }))
                                }
                            )
                        }
                        else {
                            for card in cardsForAnimation {
                                card.shake(duration: 0.3)
                                card.isSelected = false
                            }
                        }
                        
                        self.scoreGame = self.game!.score
                    }
                }
            )
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
