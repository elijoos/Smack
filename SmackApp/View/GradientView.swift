//
//  GradientView.swift
//  SmackApp
//
//  Created by COMPUTER on 4/23/18.
//  Copyright © 2018 COMPUTER. All rights reserved.
//

import UIKit

@IBDesignable
class GradientView: UIView {

    //colors for gradient
    
    //when setting the color, after the = sign say " color literal " and you can choose colors
    @IBInspectable var topColor: UIColor =  #colorLiteral(red: 0.2901960784, green: 0.3019607843, blue: 0.8470588235, alpha: 1){
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable var bottomColor: UIColor = #colorLiteral(red: 0.1725490196, green: 0.831372549, blue: 0.8470588235, alpha: 1) {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    //Need this because layoutSubviews() is called when setNeedsLayout() is called when we want to update the UI
    override func layoutSubviews() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        //start and end points of gradient. Coordinate system of (0,0) to (1,1)
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
        
    }
    
}
