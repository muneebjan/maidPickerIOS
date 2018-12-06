//
//  chatInboxModel.swift
//  Maidpicker
//
//  Created by Apple on 06/12/2018.
//  Copyright © 2018 devstop. All rights reserved.
//

import Foundation

class chatInboxModel {
    
    static let instance = chatInboxModel()
    
    var inboxUsersArray = [chatInboxModel]()
    
    var key: String?
    var image: String?
    var name: String?
    var token: String?
    
}
