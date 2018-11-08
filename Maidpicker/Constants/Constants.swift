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
// =============== HomeWhen ==================== 
let URL_Home_When = "http://ec2-18-222-165-11.us-east-2.compute.amazonaws.com:\(port)/api/v1/client/when"
let URL_Home_TaskSize = "http://ec2-18-222-165-11.us-east-2.compute.amazonaws.com:\(port)/api/v1/client/size"
// =============== HomeWhen DATE ====================
let URL_Date = "http://ec2-18-222-165-11.us-east-2.compute.amazonaws.com:\(port)/api/v1/client/date" //?wid=1&day=5&month=8


// service provider

let URL_SPLogin = "http://ec2-18-222-165-11.us-east-2.compute.amazonaws.com:\(port)/api/v1/provider/login"
let URL_SPSignUP = "http://ec2-18-222-165-11.us-east-2.compute.amazonaws.com:\(port)/api/v1/provider/signup"
let URL_SPupdateProfile = "http://ec2-18-222-165-11.us-east-2.compute.amazonaws.com:\(port)/api/v1/provider/update"
// getting Extra Data:
let URL_gettingExtraData = "http://ec2-18-222-165-11.us-east-2.compute.amazonaws.com:\(port)/api/v1/client/GetExtrasData"
let s3_baseURL = "https://s3.us-east-2.amazonaws.com/maidpickers/"
// BIDDING API; ?uid=5&aid=10&pid=15&wid=20&sid=25&often=Hi&spid=30&eid=35&pic1=40&pic2=45&pic3=50&deep=55&cabinet=60&fridge=65&oven=70&laundry=75&windows=80
let URL_StartBidding = "http://ec2-18-222-165-11.us-east-2.compute.amazonaws.com:\(port)/api/v1/client/bids"


