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
// fcm_token saving api
let URL_saveFcm_Token = "http://ec2-18-222-165-11.us-east-2.compute.amazonaws.com:\(port)/api/v1/client/notification/update"
// notification sending
let URL_insert_Notification = "http://ec2-18-222-165-11.us-east-2.compute.amazonaws.com:\(port)/api/v1/notification/insert"
// get offers data
let URL_getOffersData_Requests = "http://ec2-18-222-165-11.us-east-2.compute.amazonaws.com:\(port)/api/v1/offer/provider"
// Ongoing Request Hire API
let URL_Ongoing_Request_HireApi = "http://ec2-18-222-165-11.us-east-2.compute.amazonaws.com:\(port)/api/v1/client/StatusCompleted"
// Ongoing Upcoming Data API
let URL_Ongoing_Upcoming = "http://ec2-18-222-165-11.us-east-2.compute.amazonaws.com:\(port)/api/v1/client/getOffersBooked"
// ongoing upcoming Mark as complete
let URL_Ongoing_Upcoming_markComplete = "http://ec2-18-222-165-11.us-east-2.compute.amazonaws.com:\(port)/api/v1/client/StatusCompleted"
// review posting API
let URL_Ongoing_Upcoming_Review = "http://ec2-18-222-165-11.us-east-2.compute.amazonaws.com:\(port)/api/v1/order/rating/update"

// ================= NOTIFICATION APIS =================

let URL_Send_Message = "http://ec2-18-222-165-11.us-east-2.compute.amazonaws.com:\(port)/api/v1/notification/send/message"

let URL_Place_Order = "http://ec2-18-222-165-11.us-east-2.compute.amazonaws.com:\(port)/api/v1/notification/place/order"

let URL_Place_Offer = "http://ec2-18-222-165-11.us-east-2.compute.amazonaws.com:\(port)/api/v1/notification/place/offer"

let URL_Quick_Job = "http://ec2-18-222-165-11.us-east-2.compute.amazonaws.com:\(port)/api/v1/notification/quick/job"

let URL_Order_Complete = "http://ec2-18-222-165-11.us-east-2.compute.amazonaws.com:\(port)/api/v1/notification/order/complete"

let URL_Order_Review = "http://ec2-18-222-165-11.us-east-2.compute.amazonaws.com:\(port)/api/v1/notification/order/review"



// ==================== SERVICE PROVIDER APIS =========================

let URL_SPLogin = "http://ec2-18-222-165-11.us-east-2.compute.amazonaws.com:\(port)/api/v1/provider/login"
let URL_SPSignUP = "http://ec2-18-222-165-11.us-east-2.compute.amazonaws.com:\(port)/api/v1/provider/signup"
let URL_SPupdateProfile = "http://ec2-18-222-165-11.us-east-2.compute.amazonaws.com:\(port)/api/v1/provider/update"
// getting Extra Data:
let URL_gettingExtraData = "http://ec2-18-222-165-11.us-east-2.compute.amazonaws.com:\(port)/api/v1/client/GetExtrasData"
let s3_baseURL = "https://s3.us-east-2.amazonaws.com/maidpickers/"
// BIDDING API;
let URL_StartBidding = "http://ec2-18-222-165-11.us-east-2.compute.amazonaws.com:\(port)/api/v1/client/bids"
// BIDDING OFFER API:
let URL_BiddingOffer = "http://ec2-18-222-165-11.us-east-2.compute.amazonaws.com:\(port)/api/v1/client/counter"
// getting Offer Data:
let URL_GetOfferRequest = "http://ec2-18-222-165-11.us-east-2.compute.amazonaws.com:\(port)/api/v1/client/getOffersRequest"
// cancel request:
let URL_cancelRequest = "http://ec2-18-222-165-11.us-east-2.compute.amazonaws.com:\(port)/api/v1/client/StatusCancelled"
// Insert Default Rating ==========  ?spid=4&cid=4&jobs=ahtasham&rating=5start
let URL_ServiceProviderInsertRating = "http://ec2-18-222-165-11.us-east-2.compute.amazonaws.com:\(port)/api/v1/orders/rating/insert"
// gettingProviders data
let URL_getServiceProviderData = "http://ec2-18-222-165-11.us-east-2.compute.amazonaws.com:\(port)/api/v1/orders/serviceprovider/get"
// Service Provider Home bid data
let URL_SPgetBidData = "http://ec2-18-222-165-11.us-east-2.compute.amazonaws.com:\(port)/api/v1/bids/listing/noprice"
let URL_SPgetQuickJobData = "http://ec2-18-222-165-11.us-east-2.compute.amazonaws.com:\(port)/api/v1/bids/listing/withprice"

let URL_SPget_BidDetails = "http://ec2-18-222-165-11.us-east-2.compute.amazonaws.com:\(port)/api/v1/offer/individual"

//Notification Constants

