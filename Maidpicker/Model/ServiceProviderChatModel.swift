//
//  ServiceProviderChatModel.swift
//  Maidpicker
//
//  Created by Apple on 07/12/2018.
//  Copyright © 2018 devstop. All rights reserved.
//

import Foundation

class ServiceProviderChatModel: NSObject {
    
    static let instance = ServiceProviderChatModel()
    
    var chatArray = [ServiceProviderChatModel]()
    
    var from: String?
    var message: String?
    var seen: Int?
    var time: Double?
    var type: String?
    
}
