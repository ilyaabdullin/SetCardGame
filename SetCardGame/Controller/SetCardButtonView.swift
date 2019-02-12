//
//  SetCardButton.swift
//  SetCardGame
//
//  Created by Ilya Abdullin on 11/02/2019.
//  Copyright © 2019 Ilya Abdullin. All rights reserved.
//

import UIKit

@IBDesignable class SetCardButtonView: UIButton {
    
    @IBInspectable var symbol = ["▲", "■", "●"][Int.random(in: 0...2)]
    @IBInspectable var number = [1, 2, 3][Int.random(in: 0...2)]
    @IBInspectable var color = [UIColor.red, UIColor.green, UIColor.purple][Int.random(in: 0...2)]
    @IBInspectable var shade = [1, 2, 3][Int.random(in: 0...2)]
    var isStoryboardView = true //this var need for viewing on storyboard
    
    var card: SetCard? {
        didSet {
            isStoryboardView = false
            
            if card != nil {
                symbol = card!.symbol.rawValue
                number = card!.number.rawValue
                color = UIColor(rgb: UInt(card!.color.rawValue))
                shade = card!.shading.rawValue
            }
        }
    }

    override func draw(_ rect: CGRect) {
        if card == nil, !isStoryboardView {
            self.backgroundColor = UIColor.black
        }
        else {
            let roundedRect = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
            roundedRect.addClip()
            UIColor.white.setFill()
            roundedRect.fill()
            
            self.setAttributedTitle(descriptionSetCard(), for: .normal)
        }
    }
    
    func descriptionSetCard() -> NSAttributedString {
        //symbols: number & shape
        let separator = (UIScreen.main.traitCollection.verticalSizeClass == .regular) ? "\n" : " "
        
        //attributes: fill & color
        let shadingAttributes: [Int: (alpha: CGFloat, strokeWidth: CGFloat)] = [1: (1.0, -8), 2: (0.5, -8), 3: (0.15, 8)]
        let (alpha, strokeWidth) = shadingAttributes[shade]!
        
        var font = UIFont.preferredFont(forTextStyle: .body).withSize(fontSize)
        font = UIFontMetrics(forTextStyle: .body).scaledFont(for: font)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        //paragraphStyle.
        
        let attributes:[NSAttributedString.Key : Any] = [
            .strokeColor: color,
            .strokeWidth: strokeWidth,
            .foregroundColor: color.withAlphaComponent(alpha),
            .font: font,
            .paragraphStyle: paragraphStyle
        ]
        
        let cardValueString = Array.init(repeating: symbol, count: number).joined(separator: separator)
        return NSAttributedString(string: cardValueString, attributes: attributes)
    }

}

extension SetCardButtonView {
    private struct SizeRatio {
        static let cornerRadiiusToBoundsHeight: CGFloat = 0.06
        static let fontSizeToBoundsHeight: CGFloat = 0.25
//        static let cornerOffsetToCornerRadius: CGFloat = 0.33
//        static let faceCardImageSizeToBoundsSize: CGFloat = 0.75
    }
    
    private var cornerRadius: CGFloat {
        return bounds.size.height * SizeRatio.cornerRadiiusToBoundsHeight
    }
    
//    private var cornerOffset: CGFloat {
//        return cornerRadius * SizeRatio.cornerOffsetToCornerRadius
//    }
//
    private var fontSize: CGFloat {
        return bounds.size.height * SizeRatio.fontSizeToBoundsHeight
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
