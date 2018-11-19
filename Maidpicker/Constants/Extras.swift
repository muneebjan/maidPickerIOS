//
//  Extras.swift
//  Maidpicker
//
//  Created by Apple on 19/09/2018.
//  Copyright © 2018 devstop. All rights reserved.
//

import Foundation

class Extras {
    static let singleton = Extras()
    
    var addressID: Int?
    var tempBidID: Int?
    
    func getCurrentTime() -> String {
        
        let date = Date()
        let calender = Calendar.current
        let components = calender.dateComponents([.month,.day,.hour,.minute], from: date)
        
        let month = components.month
        let day = components.day
        let hour = components.hour
        let minute = components.minute
        
        let today_string = String(month!) + ":" + String(day!) + ":" + String(hour!)  + ":" + String(minute!)
        print("currentDate&Time: \(today_string)")
        
        return today_string
    }
    
    
    // removing all ID's and data
    func removingID() {
        Extras.singleton.addressID = nil
        WhenModel.singleton.whenID = nil
        TaskSizeModel.singleton.TaskSizeID = nil
        HowOften_Extra_Model.singleton.howOften = nil
        HowOften_Extra_Model.singleton.completeExtraDataArray.removeAll()
        SpecialServiceModel.singleton.photoArray.removeAll()
    }
    
}
