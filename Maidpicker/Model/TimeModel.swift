//
//  TimeModel.swift
//  MailPicker
//
//  Created by Apple on 28/06/2018.
//  Copyright © 2018 devstop. All rights reserved.
//

import Foundation

class TimeModel {
    
    static let TimeInstance = TimeModel()
    
    var startTime: String? // 15:55
    var endTime: String?
    var startDate: String? // MM/dd
    var dateArray: [String] = []
}
