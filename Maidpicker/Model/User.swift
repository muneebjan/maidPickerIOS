//
//  user.swift
//  Maidpicker
//
//  Created by Apple on 07/09/2018.
//  Copyright © 2018 devstop. All rights reserved.
//

import Foundation
import UIKit

class User {
    
    static let userInstance = User()
    
    var Userid: String?
    var name: String?
    var email: String?
    var password: String?
    var mobilephone: String?
    var fcmToken: String?
    var imageURL: String?
    var zipcode: String?
    var userImage: UIImage?

}
