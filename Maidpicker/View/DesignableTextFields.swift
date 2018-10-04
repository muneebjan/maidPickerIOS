//
//  DesignableTextFields.swift
//  Maidpicker
//
//  Created by Apple on 14/09/2018.
//  Copyright © 2018 devstop. All rights reserved.
//


import UIKit
@IBDesignable

class DesignableTextFields: UITextField {
    
    @IBInspectable var rightImage: UIImage?{
        didSet {
            updateView()
        }
        
    }
    
    func updateView()  {
        
        if let image = rightImage{
            rightViewMode = .always
            let imageView = UIImageView(frame: CGRect(x: -5, y: 0, width: 15, height: 15))
            imageView.image = image
            
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 15))
            
            view.addSubview(imageView)
            
            rightView = view
            
        }else{
            rightViewMode = .never
        }
        
    }
    
}
