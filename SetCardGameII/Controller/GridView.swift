//
//  CridViewController.swift
//  SetCardGame
//
//  Created by Ilya Abdullin on 21/02/2019.
//  Copyright © 2019 Ilya Abdullin. All rights reserved.
//

import UIKit

class GridView: UIView {
    
    var cardViews = [SetCardView]() {
        willSet { removeSubviews() }
        didSet { addSubviews(); setNeedsLayout() }
    }
    
    private func removeSubviews() {
        for card in cardViews {
            card.removeFromSuperview()
        }
    }
    
    private func addSubviews() {
        for card in cardViews {
            addSubview(card)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var grid = Grid(
            layout: Grid.Layout.aspectRatio(cellAspectRatio),
            frame: bounds)
        
        grid.cellCount = cardViews.count
        
        for row in 0..<grid.dimensions.rowCount {
            for column in 0..<grid.dimensions.columnCount {
                if cardViews.count > (row * grid.dimensions.columnCount + column) {
                    cardViews[row * grid.dimensions.columnCount + column].frame = grid[row,column]!.insetBy(
                        dx: spacingDx, dy: spacingDy)
                }
            }
        }
    }
    
    //constants
    private var cellAspectRatio: CGFloat {
        return bounds.width / bounds.height
    }

    private let spacingDx: CGFloat  = 3.0
    private let spacingDy: CGFloat  = 3.0
}
