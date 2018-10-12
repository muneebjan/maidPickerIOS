//
//  AddressArray.swift
//  Maidpicker
//
//  Created by Apple on 08/10/2018.
//  Copyright © 2018 devstop. All rights reserved.
//

import Foundation

class AddressArray {
    static let singleton = AddressArray()
    
    var addressArray: [Address_RoomsDetail] = []
    var roomDetailsArray: [RoomDetails] = []
}
