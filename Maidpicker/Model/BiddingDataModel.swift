//
//  BiddingDataModel.swift
//  Maidpicker
//
//  Created by Apple on 13/11/2018.
//  Copyright © 2018 devstop. All rights reserved.
//

import Foundation

class BiddingDataModel {
    
    static let instance = BiddingDataModel()
    
    var biddingArray = [BiddingDataModel]()
    
    var bidID: Int = 0
    var day: Int = 0
    var month: Int = 0
    var price: Int = 0
    var totalOffers: Int = 0
    var deepclean: Int?
    var insidecabinet: Int?
    var insidefridge: Int?
    var insideoven: Int?
    var laundry: Int?
    var InteriorWindow: Int?
    
    var OfferDetails: [String] = []
    var DetailArray: [[String]] = []

    
}
