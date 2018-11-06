//
//  ServiceProvderUser.swift
//  Maidpicker
//
//  Created by Apple on 23/10/2018.
//  Copyright © 2018 devstop. All rights reserved.
//

import Foundation
import UIKit
class ServiceProviderUser {
    
    static let instance = ServiceProviderUser()
    
    var id: String?
    var name: String?
    var email: String?
    var password: String?
    var experience: String?
    var contact: String?
    var document: String?
    var zipcode: String?
    var bio: String?
    var hourlyrate: String?
    var image: String?
    var imageURL: String?
    var spuserImage: UIImage?
}
