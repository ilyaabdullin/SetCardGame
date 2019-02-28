//
//  SetCardButton.swift
//  SetCardGame
//
//  Created by Ilya Abdullin on 11/02/2019.
//  Copyright © 2019 Ilya Abdullin. All rights reserved.
//

import UIKit

@IBDesignable class SetCardView: UIView {
    
    @IBInspectable var cardColor: UIColor = UIColor.white { didSet {setNeedsDisplay()} }
    
    @IBInspectable var isSelected: Bool = false { didSet {setNeedsDisplay()} }
    
    @IBInspectable var symbolInt: Int = [1, 2, 3][Int.random(in: 0...2)] {
        didSet {
            symbol = SetCard.Symbol(rawValue: symbolInt) ?? SetCard.Symbol.diamond
        }
    }
    
    private var symbol = SetCard.Symbol.allCases[Int.random(in: 0...2)] { didSet {setNeedsDisplay()} }
    
    @IBInspectable var countInt: Int = [1, 2, 3][Int.random(in: 0...2)] {
        didSet {
            count = SetCard.Count(rawValue: countInt) ?? SetCard.Count.one
        }
    }
    
    private var count = SetCard.Count.allCases[Int.random(in: 0...2)] { didSet {setNeedsDisplay()} }
    
    @IBInspectable var colorInt: Int = [1, 2, 3][Int.random(in: 0...2)] {
        didSet {
            switch colorInt {
            case 1:
                color = UIColor(rgb: UInt(SetCard.Filling.green.rawValue))
            case 2:
                color = UIColor(rgb: UInt(SetCard.Filling.purple.rawValue))
            case 3:
                color = UIColor(rgb: UInt(SetCard.Filling.red.rawValue))
            default:
                color = UIColor(rgb: UInt(SetCard.Filling.green.rawValue))
            }
        }
    }
    
    private var color = [UIColor.red, UIColor.green, UIColor.purple][Int.random(in: 0...2)] { didSet {setNeedsDisplay()} }
    
    @IBInspectable var shadeInt: Int = [1, 2, 3][Int.random(in: 0...2)] {
        didSet {
            shade = SetCard.Shading(rawValue: shadeInt) ?? SetCard.Shading.open
        }
    }
    
    private var shade = SetCard.Shading.allCases[Int.random(in: 0...2)] { didSet {setNeedsDisplay()} }
    
    var card: SetCard? {
        didSet {
            if card != nil {
                isSelected = false
                symbol = card!.symbol
                count = card!.count
                color = UIColor(rgb: UInt(card!.color.rawValue))
                shade = card!.shade
            }
        }
    }
}

//drawing
extension SetCardView {
    override func draw(_ rect: CGRect) {
        if !isHidden {
            //background color
            cardColor = isSelected == true ? UIColor.lightGray : UIColor.white
            
            //rounded corners
            let roundedRect = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
            cardColor.setFill()
            roundedRect.fill()
            
            //shape, color, count and shade
            drawShapes()
        }
    }
    
    private func drawShapes() {
        color.setFill()
        color.setStroke()
        
        for rectangle in rectanglesForShapes {
            drawShape(in: rectangle)
        }
    }
    
    private func drawShape(in rect: CGRect) {
        let path: UIBezierPath
        
        switch symbol {
        case .diamond:
            path = diamondPath(for: rect)
        case .oval:
            path = ovalPath(for: rect)
        case .squiggle:
            path = squigglePath(for: rect)
        }
        
        path.lineWidth = lineWidth
        path.stroke()
        
        switch shade {
        case .solid:
            path.fill()
        case .striped:
            addStripes(path: path, in: rect)
        default:
            break
        }
    }
    
    private func diamondPath(for rect: CGRect) -> UIBezierPath {
        let diamond = UIBezierPath()
        
        diamond.move(to: CGPoint(x: rect.minX, y: rect.midY))
        diamond.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        diamond.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        diamond.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        diamond.close()
        
        return diamond
    }
    
    private func ovalPath(for rect: CGRect) -> UIBezierPath {
        
        let oval = UIBezierPath()
        
        let radius = isPortraitView ? rect.height / 2 : rect.width / 2
        
        if isPortraitView {
            oval.addArc(withCenter: CGPoint(x: rect.minX + radius, y: rect.minY + radius),
                        radius: radius, startAngle: CGFloat.pi/2, endAngle: CGFloat.pi*3/2, clockwise: true)
            oval.addLine(to: CGPoint(x: rect.maxX - radius, y: rect.minY))
            oval.addArc(withCenter: CGPoint(x: rect.maxX - radius, y: rect.maxY - radius),
                        radius: radius, startAngle: CGFloat.pi*3/2, endAngle: CGFloat.pi/2, clockwise: true)
            oval.close()
        }
        else {
            oval.addArc(withCenter: CGPoint(x: rect.minX + radius, y: rect.minY + radius),
                        radius: radius, startAngle: CGFloat.pi, endAngle: CGFloat.pi*0, clockwise: true)
            oval.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - radius))
            oval.addArc(withCenter: CGPoint(x: rect.maxX - radius, y: rect.maxY - radius),
                        radius: radius, startAngle: CGFloat.pi*0, endAngle: CGFloat.pi, clockwise: true)
            oval.close()
        }
        
        
        return oval
    }
    
    private func squigglePath(for rect: CGRect) -> UIBezierPath {
        let squiggle = UIBezierPath()
        
        let point1 = isPortraitView ? CGPoint(x: rect.minX, y: rect.maxY) : CGPoint(x: rect.maxX, y: rect.maxY)
        let point2 = isPortraitView ? CGPoint(x: rect.minX + rect.width/3, y: rect.minY - rect.height * 1.5) : CGPoint(x: rect.minX - rect.width * 1.5, y: rect.minY + (2 * rect.height)/3)
        let point4 = isPortraitView ? CGPoint(x: rect.minX + (2 * rect.width)/3, y: rect.maxY + rect.height * 1.5) : CGPoint(x: rect.maxX + rect.width * 1.5, y: rect.minY + rect.height/3)
        let point5 = isPortraitView ? CGPoint(x: rect.maxX, y: rect.minY) : CGPoint(x: rect.minX, y: rect.minY)
        
        squiggle.move(to: point1)
        squiggle.addCurve(to: point5, controlPoint1: point2, controlPoint2: point4)
        squiggle.close()
        
        return squiggle
    }
    
    private func addStripes(path: UIBezierPath, in rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context?.saveGState()
        path.addClip()
        
        let stripe = UIBezierPath()
        stripe.lineWidth = stripeLineWidth
        if isPortraitView {
            stripe.move(to: CGPoint(x: rect.minX, y: bounds.minY ))
            stripe.addLine(to: CGPoint(x: rect.minX, y: bounds.maxY))
        }
        else {
            stripe.move(to: CGPoint(x: rect.minX, y: bounds.minY ))
            stripe.addLine(to: CGPoint(x: rect.maxX, y: bounds.minY))
        }
        
        
        let stripeCount = Int( (isPortraitView ? bounds.width : bounds.height) / stripeSpace)
        
        for _ in 1...stripeCount {
            let translation = isPortraitView ? CGAffineTransform(translationX: stripeSpace, y: 0) : CGAffineTransform(translationX: 0, y: stripeSpace)
            stripe.apply(translation)
            stripe.stroke()
        }
        
        context?.restoreGState()
    }
}

//drawing constants and other stuff
extension SetCardView {
    private struct SizeRatio {
        static let cornerRadiusToBoundsHeight: CGFloat = 0.06
        static let paddingToBoundsSize: CGFloat = 0.06
        static let lineWidthToBoundsMostSide: CGFloat = 0.01
    }
    
    private var cornerRadius: CGFloat {
        return bounds.size.height * SizeRatio.cornerRadiusToBoundsHeight
    }
    
    private var padding: (width: CGFloat, height: CGFloat) {
        return (bounds.size.width * SizeRatio.paddingToBoundsSize, bounds.size.height * SizeRatio.paddingToBoundsSize)
    }
    
    private var rectangleShapeSize: (width: CGFloat, height: CGFloat) {
        return ((bounds.size.width - padding.width * 4) / 3, (bounds.size.height - padding.height * 4) / 3)
    }
    
    private var lineWidth: CGFloat {
        return isPortraitView ? bounds.size.height * SizeRatio.lineWidthToBoundsMostSide : bounds.size.width * SizeRatio.lineWidthToBoundsMostSide
    }
    
    private var stripeLineWidth: CGFloat {
        return lineWidth / 3
    }
    
    private var stripeSpace: CGFloat {
        return lineWidth * 2
    }
    
    private var isPortraitView: Bool {
        return rectangleShapeSize.width <= rectangleShapeSize.height
    }
    
    private var rectanglesForShapes: [CGRect] {
        let (widthRectangleForShape, heightRectangleForShape) = rectangleShapeSize
        let totalHeight = heightRectangleForShape * CGFloat(count.rawValue) + padding.height * CGFloat(count.rawValue - 1)
        let totalWidth = widthRectangleForShape * CGFloat(count.rawValue) + padding.width * CGFloat(count.rawValue - 1)
        let verticalPadding = (bounds.size.height - totalHeight) / 2
        let horizontalPadding = (bounds.size.width - totalWidth) / 2
        
        var rectanglesForShapes = [CGRect]()
        
        if isPortraitView {
            for nextShapeNumber in 1...count.rawValue {
                rectanglesForShapes.append(
                    CGRect(
                        x: bounds.minX + padding.width * 3,
                        y: bounds.minY + verticalPadding + (heightRectangleForShape + padding.height) * CGFloat(nextShapeNumber - 1),
                        width: bounds.width - padding.width * 3 * 2,
                        height: heightRectangleForShape
                    )
                )
            }
        }
        else {
            for nextShapeNumber in 1...count.rawValue {
                rectanglesForShapes.append(
                    CGRect(
                        x: bounds.minX + horizontalPadding + (widthRectangleForShape + padding.width) * CGFloat(nextShapeNumber - 1),
                        y: bounds.minY + padding.height * 3,
                        width: widthRectangleForShape,
                        height: bounds.height - padding.height * 3 * 2
                    )
                )
            }
        }
        
        
        return rectanglesForShapes
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

extension CGPoint {
    func offsetBy(dx: CGFloat, dy: CGFloat) -> CGPoint {
        return CGPoint(x: x+dx, y: y+dy)
    }
}
