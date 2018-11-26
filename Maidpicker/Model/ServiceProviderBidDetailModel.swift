//
//  ServiceProviderBidDetailModel.swift
//  Maidpicker
//
//  Created by Apple on 26/11/2018.
//  Copyright © 2018 devstop. All rights reserved.
//

import Foundation

class ServiceProviderBidDetailModel {
    
    
    static let instance = ServiceProviderBidDetailModel()
    
    var BidDetail = [ServiceProviderBidDetailModel]()
    
    
    var Bidid: Int = 0
    var uid: Int = 0
    var aid: Int = 0
    var wid: Int = 0
    var often: String = ""
    var pic1: String = ""
    var pic2: String = ""
    var pic3: String = ""

    var deep: Int = 0
    var cabinet: Int = 0
    var fridge: Int = 0
    var oven: Int = 0
    var laundry: Int = 0
    var windows: Int = 0
    var carpetarea: Int = 0
    var carpets: Int = 0
    var notes: String = ""
    var name: String = ""
    var bedrooms: Int = 0
    var bathrooms: Int = 0
    var otherrooms: Int = 0
    var area: Int = 0
    var sid: Int = 0
    
    var address1: String = ""
    var address2: String = ""

    var Addressid: Int = 0

    
}
