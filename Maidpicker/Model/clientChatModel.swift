//
//  clientChatModel.swift
//  Maidpicker
//
//  Created by Apple on 29/11/2018.
//  Copyright © 2018 devstop. All rights reserved.
//

import Foundation

class clientChatModel {
    
    static let instance = clientChatModel()

    var chatArray = [clientChatModel]()
    
    var from: String?
    var message: String?
    var seen: Int?
    var time: Double?
    var type: String?
    
}
