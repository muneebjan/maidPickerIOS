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
    
    var bidID: Int = 0
    var day: Int = 0
    var month: Int = 0
    var price: Int = 0
    var name: String = ""
    var deepclean: Int?
    var insidecabinet: Int?
    var insidefridge: Int?
    var insideoven: Int?
    var laundry: Int?
    var InteriorWindow: Int?
    
    var DetailArray: [[String]] = []
}
