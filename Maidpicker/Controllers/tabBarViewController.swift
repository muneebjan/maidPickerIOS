//
//  tabBarViewController.swift
//  Maidpicker
//
//  Created by Apple on 18/09/2018.
//  Copyright © 2018 devstop. All rights reserved.
//

import UIKit

class tabBarViewController: UITabBarController {

    @IBInspectable var defaultIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedIndex = defaultIndex
    }

}
