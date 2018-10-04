//
//  CustomView.swift
//  Maidpicker
//
//  Created by Apple on 28/09/2018.
//  Copyright © 2018 devstop. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class Customview: UIView {
    
    
    @IBInspectable var viewColor: UIColor = UIColor.white
    @IBInspectable var viewBorderWidth: CGFloat = 0
    @IBInspectable var viewCornerRadius: CGFloat = 0
    @IBInspectable var viewBorderColor: UIColor = UIColor.clear
    
    override func awakeFromNib() {
        super.awakeFromNib()
        styleView()
    }
    
    override func prepareForInterfaceBuilder() {
        styleView()
    }
    
    func styleView() {
        
        backgroundColor = viewColor
        layer.borderWidth = viewBorderWidth
        layer.borderColor = viewBorderColor.cgColor
        layer.cornerRadius = viewCornerRadius
        
    }
}
