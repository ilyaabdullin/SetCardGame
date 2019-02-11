//
//  ViewController.swift
//  SetCardGame
//
//  Created by Ilya Abdullin on 08/02/2019.
//  Copyright © 2019 Ilya Abdullin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func descriptionSetCard(_ card: SetCard) -> NSAttributedString {
        //symbols: number & shape
        let separator = (UIScreen.main.traitCollection.verticalSizeClass == .regular) ? "\n" : " "
        
        //attributes: fill & color
        let shadingAttributes: [SetCard.Shading: (alpha: CGFloat, strokeWidth: CGFloat)] = [SetCard.Shading.solid: (1.0, -8), SetCard.Shading.striped: (0.5, -8), SetCard.Shading.open: (0.15, 8)]
        
        let (alpha, strokeWidth) = shadingAttributes[card.shading]!
        
        let color = UIColor(rgb: UInt(card.color.rawValue))
        let attributes:[NSAttributedString.Key : Any] = [
            .strokeColor: color,
            .strokeWidth: strokeWidth,
            .foregroundColor: color.withAlphaComponent(alpha),
            .font: UIFont.systemFont(ofSize: 40)
        ]
        
        return NSAttributedString(string: Array.init(repeating: card.symbol.rawValue, count: card.number.rawValue).joined(separator: separator), attributes: attributes)
    }

}

extension UIColor {
    convenience init(rgb: UInt) {
        self.init(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

