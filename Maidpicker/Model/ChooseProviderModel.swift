//
//  ServiceProviderModel.swift
//  Maidpicker
//
//  Created by Apple on 14/11/2018.
//  Copyright © 2018 devstop. All rights reserved.
//

import Foundation

class ChooseProviderModel {
    
    static let instance = ChooseProviderModel()
    
    var chooseProviderArray = [ChooseProviderModel]()
    
    var spID: Int = 0
    var rating: Int = 0
    var image: String = ""
    var hourlyrate: Int = 0
    var jobs: Int = 0
    var review: Int = 0
    var name: String = ""
    
    
}
