//
//  WhenModel.swift
//  Maidpicker
//
//  Created by Apple on 10/10/2018.
//  Copyright © 2018 devstop. All rights reserved.
//

import Foundation

class WhenModel {
    static let singleton = WhenModel()
    
    var calenderType: String?
    var dateTimeArray: [TimeModel] = []
    
}
