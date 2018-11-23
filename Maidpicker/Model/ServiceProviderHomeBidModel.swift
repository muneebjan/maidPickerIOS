//
//  ServiceProviderHomeBidModel.swift
//  Maidpicker
//
//  Created by Apple on 23/11/2018.
//  Copyright © 2018 devstop. All rights reserved.
//

import Foundation

class ServiceProviderHomeBidModel {
    
    static let instance = ServiceProviderHomeBidModel()
    
    var totalBidData = [ServiceProviderHomeBidModel]()
    
    var Bidid: Int = 0
    var cabinet: Int = 0
    var deep: Int = 0
    var laundry: Int = 0
    var fridge: Int = 0
    var windows: Int = 0
    var price: Int = 0
    var oven: Int = 0
    var day: Int = 0
    var month: Int = 0
    
    var bedrooms: Int = 0
    var bathrooms: Int = 0
    var otherrooms: Int = 0
    var area: Int = 0
    
    var id: Int = 0
    var clientid: Int = 0
    var name: String = ""
    
}
