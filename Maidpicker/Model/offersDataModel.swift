//
//  offersDataModel.swift
//  Maidpicker
//
//  Created by Apple on 22/11/2018.
//  Copyright © 2018 devstop. All rights reserved.
//

import Foundation

class offersDataModel {
    
    static let instance = offersDataModel()
    
    var totaloffersData = [offersDataModel]()
    
    var offerid: Int = 0
    var name: String = ""
    var image: String = ""
    var hourlyrate: Int = 0
    var jobs: Int = 0
    var rating: Int = 0
    var review: Int = 0
    var bidID: Int = 0
    var SPID: Int = 0
    var price: Int = 0
    
}
