//
//  Constants.swift
//  Maidpicker
//
//  Created by Apple on 07/09/2018.
//  Copyright © 2018 devstop. All rights reserved.
//

import Foundation

typealias CompletionHanlder = (_ Success: Bool) -> ()

let port = "4000"

let URL_Login = "http://ec2-18-222-165-11.us-east-2.compute.amazonaws.com:\(port)/api/v1/client/login"
let URL_Sigup = "http://ec2-18-222-165-11.us-east-2.compute.amazonaws.com:\(port)/api/v1/client/signup"
let URL_checkEmail = "http://ec2-18-222-165-11.us-east-2.compute.amazonaws.com:\(port)/api/v1/client/check_email"
let URL_updateProfile = "http://ec2-18-222-165-11.us-east-2.compute.amazonaws.com:\(port)/api/v1/client/update"
let URL_updatePassword = "http://ec2-18-222-165-11.us-east-2.compute.amazonaws.com:\(port)/api/v1/client/updatePassword"
let URL_AddAddress = "http://ec2-18-222-165-11.us-east-2.compute.amazonaws.com:\(port)/api/v1/client/addAddress"
let URL_DelAddress = "http://ec2-18-222-165-11.us-east-2.compute.amazonaws.com:\(port)/api/v1/address/deleteAddress"
let URL_GetAddress = "http://ec2-18-222-165-11.us-east-2.compute.amazonaws.com:\(port)/api/v1/client/getAllAddress"

let s3_baseURL = "https://s3.us-east-2.amazonaws.com/maidpickers/"
