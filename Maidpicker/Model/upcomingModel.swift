//
//  upcomingModel.swift
//  Maidpicker
//
//  Created by Apple on 12/12/2018.
//  Copyright © 2018 devstop. All rights reserved.
//

import Foundation

class upcomingModel {
    
    static let instance = upcomingModel()
    
    var DataArray = [upcomingModel]()
    
    var name: String = ""
    var spID: Int = 0
    var image: String = ""
    var id: Int = 0
    var insidecabinet: Int?
    var deepclean: Int?
    var insidefridge: Int?
    var InteriorWindow: Int?
    var price: Int = 0
    var laundry: Int?
    var insideoven: Int?
    var day: Int = 0
    var month: Int = 0
    
    
    
    
    
    
    
    
    
    var DetailArray: [[String]] = []
}
