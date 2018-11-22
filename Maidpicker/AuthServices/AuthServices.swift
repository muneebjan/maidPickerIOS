//
//  AuthServices.swift
//  Maidpicker
//
//  Created by Apple on 07/09/2018.
//  Copyright © 2018 devstop. All rights reserved.
//

import UIKit
import Foundation
import SwiftyJSON
import Alamofire

class AuthServices {
    
    var updatestatus = ""
    var loginstatus = ""
    var checkemailstatus = ""
    static let instance = AuthServices()
    
    
    func loginUser(email: String, password: String, completion: @escaping CompletionHanlder) {
        
        let parameters: Parameters = [
            
            "email":email,
            "password":password
            
        ]
        Alamofire.request(URL_Login, method: .get, parameters: parameters, encoding:URLEncoding.queryString, headers: nil).responseString {
            (response) in //Reponse is a temporary Variable where we get the result . we can write anything
            if response.result.error == nil{
                
                
                guard let data = response.data else{return}
                let json: JSON
                do{
                    json = try JSON(data: data)
                    print("Getting data from Login Api \(json)")
                    
                    let preferences = UserDefaults.standard
                    
                    
                    
                    
                    // model initializer
                    User.userInstance.Userid=json[0]["id"].stringValue
                    preferences.set(User.userInstance.Userid, forKey: "id")
                    
                    
                    
                    User.userInstance.name = json[0]["name"].stringValue
                    preferences.set(User.userInstance.name, forKey: "name")
                    
                    
                    
                    User.userInstance.email = json[0]["email"].stringValue
                    preferences.set(User.userInstance.email, forKey: "email")
                    
                    
                    
                    User.userInstance.password = json[0]["password"].stringValue
                    preferences.set(User.userInstance.password, forKey: "password")
                    
                    
                    
                    User.userInstance.mobilephone = json[0]["mobilephone"].stringValue
                    preferences.set(User.userInstance.mobilephone, forKey: "mobilephone")
                    
                    
//                    
//                    User.userInstance.fcmToken = json[0]["fcm_token"].stringValue
//                    preferences.set(User.userInstance.fcmToken, forKey: "fcm_token")
                    
                    
                    // username.png to complete ImageURL
                    let userimage = json[0]["image"].stringValue
                    let imageURL = "\(s3_baseURL)\(userimage)"
                    print("complete image URL: \(imageURL)")
                    User.userInstance.imageURL = imageURL
                    preferences.set(User.userInstance.imageURL, forKey: "imageURL")
                    
                    
                    User.userInstance.zipcode = json[0]["zipcode"].stringValue
                    preferences.set(User.userInstance.zipcode, forKey: "zipcode")
                    
//=================================== convert imageURL to UIImage: ========================================
                    
//                    let url = URL(string: imageURL)
//                    if let data = try? Data(contentsOf: url!)
//                    {
//                        User.userInstance.userImage = UIImage(data: data)
//                    }

                    
// =========================================================================================================
                    
                    if(User.userInstance.name != ""){
                        
                        self.loginstatus = "successsful"
                        completion(true)
                    }else{
                        self.loginstatus = "not success"
                        completion(true)
                    }
                    
                    
                    self.didsave(preferences: preferences)
                }
                catch
                {
                    if response.result.error == nil{
                        completion(true)
                    }
                    else{
                        completion(false)
                        debugPrint(response.result.error as Any)
                    }
                }
                
                completion(true)
            }
            else{
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    
    
    //SHARED PREFERENCES STATUS GETTER ///// ZUBAIR////
    func didsave(preferences: UserDefaults)
    {
        let didSave = preferences.synchronize()
        
        if(!didSave){
            print("NOT SAVED")
        }
        else{
            print("User Defaults Saved")
        }
    }
    
    // saving FCM-TOKEN
    
    
    func RegisterDeviceForNotification(userid: String, token: String, completion: @escaping CompletionHanlder) {
        
        let parameters: Parameters = [
            "id": userid,
            "token":token
        ]
        
        Alamofire.request(URL_saveFcm_Token, method: .post, parameters: parameters, encoding:URLEncoding.queryString, headers: nil).responseString {
            (response) in //Reponse is a temporary Variable where we get the result . we can write anything
            if response.result.error == nil{
                completion(true)
            }
            else{
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    
    
    
    func registerUser(name: String, email: String, password: String, mobilephone: String, zipcode: String, completion: @escaping CompletionHanlder) {
        
        let parameters: Parameters = [
            "name": name,
            "email":email,
            "password":password,
            "mobilephone": mobilephone,
            "zipcode": zipcode
        ]
        
        Alamofire.request(URL_Sigup, method: .post, parameters: parameters, encoding:URLEncoding.queryString, headers: nil).responseString {
            (response) in //Reponse is a temporary Variable where we get the result . we can write anything
            if response.result.error == nil{
                completion(true)
            }
            else{
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func checkEmail(email: String, completion: @escaping CompletionHanlder) {
        let parameters: Parameters = [
            "email": email
        ]
        Alamofire.request(URL_checkEmail, method: .get, parameters: parameters, encoding:URLEncoding.queryString, headers: nil).responseJSON {
            
            (response) in //Reponse is a temporary Variable where we get the result . we can write anything
            guard let data = response.data else{return}
            let json: JSON
            do{
                json = try JSON(data: data)
                if(json[0]["number"].stringValue != "0"){
                    self.checkemailstatus = "Existtss"
                    completion(true)
                }else{
                    self.checkemailstatus = "not Existts"
                    completion(true)
                }
            }
            catch
            {
                if response.result.error == nil{
                    completion(true)
                }
                else{
                    completion(false)
                    debugPrint(response.result.error as Any)
                }
            }
            
        }
        
    }
    
    
    func updateProfile(name: String, email: String, mobilephone: String, zipcode: String, image: String, completion: @escaping CompletionHanlder){
        
        let parameters: Parameters = [
            "name": name,
            "email":email,
            "mobilephone": mobilephone,
            "zipcode": zipcode,
            "image": image
        ]
        
        Alamofire.request(URL_updateProfile, method: .post, parameters: parameters, encoding:URLEncoding.queryString, headers: nil).responseJSON {
            (response) in //Reponse is a temporary Variable where we get the result . we can write anything
            guard let data = response.data else{return}
            let json: JSON
            do{
                json = try JSON(data: data)
                print("Json data = \(json[0]["error"])")
                if(self.JsonResult(json: json)){
                    print("Data not updated")
                }else{
                    print("Data updated Successfull")
                }
                completion(true)
            }
            catch
            {
                if response.result.error == nil{
                    completion(true)
                }
                else{
                    completion(false)
                    debugPrint(response.result.error as Any)
                }
            }
            
        }
        
    }
    
    
    func updatePassWord(email: String, password: String, completion: @escaping CompletionHanlder){
        
        let parameters: Parameters = [
            "email":email,
            "password": password,
        ]
        
        Alamofire.request(URL_updatePassword, method: .post, parameters: parameters, encoding:URLEncoding.queryString, headers: nil).responseJSON {
            (response) in //Reponse is a temporary Variable where we get the result . we can write anything
            guard let data = response.data else{return}
            let json: JSON
            do{
                json = try JSON(data: data)
                print("Json data = \(json[0]["error"])")
                if(self.JsonResult(json: json)){
                    print("Passsord not updated")
                }else{
                    print("Password updated Successfull")
                }
                completion(true)
            }
            catch
            {
                if response.result.error == nil{
                    completion(true)
                }
                else{
                    completion(false)
                    debugPrint(response.result.error as Any)
                }
            }
            
        }
        
    }
    
    

    // Json check Function
    
    func JsonResult(json: JSON) -> Bool {
        if(json[0]["error"] == true){
            return true
        }else{
            return false
        }
    }
    
    // add address
    
    func add_Address(uid: String, address1: String, address2: String, rooms: String, washrooms: String, otherroom: String, area: String, completion: @escaping CompletionHanlder){
        
        let parameters: Parameters = [
            "uid": uid,
            "address1":address1,
            "address2": address2,
            "rooms": rooms,
            "washrooms": washrooms,
            "otherrooms": otherroom,
            "area": area
        ]
        
        Alamofire.request(URL_AddAddress, method: .post, parameters: parameters, encoding:URLEncoding.queryString, headers: nil).responseJSON {
            (response) in //Reponse is a temporary Variable where we get the result . we can write anything
            if response.result.error == nil{
                completion(true)
                print("API CALL: Address added to database successfully")
            }
            else{
                completion(false)
                debugPrint(response.result.error as Any)
            }
            
        }
        
    }
    
    
    func Delete_Address(uid: String, id: String, completion: @escaping CompletionHanlder){
        
        let parameters: Parameters = [
            "uid": uid,
            "id": id
        ]
        
        Alamofire.request(URL_DelAddress, method: .post, parameters: parameters, encoding:URLEncoding.queryString, headers: nil).responseString {
            (response) in //Reponse is a temporary Variable where we get the result . we can write anything
            if response.result.error == nil{
                completion(true)
                print("API CALL: Address added to database successfully \(response.value)")
            }
            else{
                completion(false)
                debugPrint(response.result.error as Any)
            }
            
        }
        
    }
    
    func getAddressbyID(userid: String, completion: @escaping CompletionHanlder) {
        let parameters: Parameters = [
            "uid": userid
        ]
        Alamofire.request(URL_GetAddress, method: .get, parameters: parameters, encoding:URLEncoding.queryString, headers: nil).responseJSON {
            
            (response) in //Reponse is a temporary Variable where we get the result . we can write anything
            guard let data = response.data else{return}
            let json: JSON
            do{
                json = try JSON(data: data)
                print(json)
                print(json.count)
                
                // removing all data from arrays
//                AddressArray.singleton.addressArray.removeAll()
//                AddressArray.singleton.roomDetailsArray.removeAll()
                
                for i in 0..<json.count {
                    
                    let Addressobj = Address_RoomsDetail()
                    Addressobj.addressID = json[i]["id"].intValue
                    Addressobj.AddressName = json[i]["address1"].stringValue
                    Addressobj.AddressDetail = json[i]["address2"].stringValue
                    
                    AddressArray.singleton.addressArray.append(Addressobj)

                    let roomsObj = RoomDetails()
                    roomsObj.numberOfRooms = json[i]["rooms"].stringValue
                    roomsObj.numberOfBathrooms = json[i]["washrooms"].stringValue
                    roomsObj.otherRooms = json[i]["otherrooms"].stringValue
                    roomsObj.AreaOfRoom = json[i]["area"].stringValue
                    
                    AddressArray.singleton.roomDetailsArray.append(roomsObj)
                    
                }
                completion(true)
                print("address Array count(API): \(AddressArray.singleton.addressArray.count)")
                print("room detail Array count(API): \(AddressArray.singleton.roomDetailsArray.count)")
                
            }
            catch
            {
                if response.result.error == nil{
                    completion(true)
                }
                else{
                    completion(false)
                    debugPrint(response.result.error as Any)
                }
            }
            
        }
        
    }
    
 
    
    // HomeWhen dataStoring API // ===== ?type=abc&subtype=ahtasham&stime=shami&etime=zub
    
    func HomeWhenDataSending(type: String, subtype: String, startTime: String, endTime: String, completion: @escaping CompletionHanlder){
        
        let parameters: Parameters = [
            "type": type,
            "subtype":subtype,
            "stime": startTime,
            "etime": endTime
        ]
        
        Alamofire.request(URL_Home_When, method: .post, parameters: parameters, encoding:URLEncoding.queryString, headers: nil).responseJSON {
            (response) in //Reponse is a temporary Variable where we get the result . we can write anything
            guard let data = response.data else{return}
            let json: JSON
            do{
                json = try JSON(data: data)
                print("Json data = \(json)")
                WhenModel.singleton.whenID = json[0]["id"].intValue
                completion(true)
            }
            catch
            {
                if response.result.error == nil{
                    completion(true)
                }
                else{
                    completion(false)
                    debugPrint(response.result.error as Any)
                }
            }
            
        }
        
    }
    
    // HOME WHEN DATE API CALLING
     //?wid=1&day=5&month=8
    func HomeWhenDATE(whenID: String, day: String, month: String, completion: @escaping CompletionHanlder){
        
        let parameters: Parameters = [
            "wid": whenID,
            "day":day,
            "month": month
        ]
        
        Alamofire.request(URL_Date, method: .post, parameters: parameters, encoding:URLEncoding.queryString, headers: nil).responseJSON {
            (response) in //Reponse is a temporary Variable where we get the result . we can write anything
            guard let data = response.data else{return}
            let json: JSON
            do{
                json = try JSON(data: data)
                print("Json data = \(json)")
                WhenModel.singleton.whenDateID = json[0]["id"].intValue
                completion(true)
            }
            catch
            {
                if response.result.error == nil{
                    completion(true)
                }
                else{
                    completion(false)
                    debugPrint(response.result.error as Any)
                }
            }
            
        }
        
    }
    
    
    
    
    // HomeTaskSize dataStoring API // ===== ?bedrooms=5&bathrooms=8&otherrooms=7&area=142525sqft
    
    func HomeTaskSizeDataSending(bed: String, bath: String, otherrooms: String, area: String, completion: @escaping CompletionHanlder){
        
        let parameters: Parameters = [
            "bedrooms": bed,
            "bathrooms":bath,
            "otherrooms": otherrooms,
            "area": area
        ]
        
        Alamofire.request(URL_Home_TaskSize, method: .post, parameters: parameters, encoding:URLEncoding.queryString, headers: nil).responseJSON {
            (response) in //Reponse is a temporary Variable where we get the result . we can write anything
            guard let data = response.data else{return}
            let json: JSON
            do{
                json = try JSON(data: data)
                print("Json data = \(json)")
                TaskSizeModel.singleton.TaskSizeID = json[0]["id"].intValue
                completion(true)
            }
            catch
            {
                if response.result.error == nil{
                    completion(true)
                }
                else{
                    completion(false)
                    debugPrint(response.result.error as Any)
                }
            }
            
        }
        
    }
    
    // GETTING EXTRA DATA
    
    
    func gettingExtraData(id: Int, completion: @escaping CompletionHanlder) {
        let parameters: Parameters = [
            "id": id
        ]
        Alamofire.request(URL_gettingExtraData, method: .get, parameters: parameters, encoding:URLEncoding.queryString, headers: nil).responseJSON {
            
            (response) in //Reponse is a temporary Variable where we get the result . we can write anything
            guard let data = response.data else{return}
            let json: JSON
            do{
                json = try JSON(data: data)
                print(json)
                print(json.count)


                ExtraModel.singleton.money = json[0]["price"].intValue
                ExtraModel.singleton.eta = json[0]["time"].intValue
                
                completion(true)
                
            }
            catch
            {
                if response.result.error == nil{
                    completion(true)
                }
                else{
                    completion(false)
                    debugPrint(response.result.error as Any)
                }
            }
            
        }
        
    }

//    BIDDING API; ?uid=5&aid=10&pid=15&wid=20&sid=25&often=Hi&spid=30&eid=35&pic1=40&pic2=45&pic3=50&deep=55&cabinet=60&fridge=65&oven=70&laundry=75&windows=80
    
    
    
// =======================================================================================================================================================
//================================================================= BIDDING API ==========================================================================
// =======================================================================================================================================================
    func BiddingAPI(userid: String, addressid: Int, whenId: Int, tasksizeID: Int, Often: String, serviceProviderID: Int, photo1: String, photo2: String, photo3: String, deepclean: Int, insideCabinet: Int, insideFridge: Int, insideOven: Int, laundry: Int, window: Int, allrooms: Int, area: Int, notes: String, totalPrice: Int, status: String, completion: @escaping CompletionHanlder){
        
        let parameters: Parameters = [
            "uid": userid,
            "aid": addressid,
            "wid": whenId,
            "sid": tasksizeID,
            "often": Often,
            "spid": serviceProviderID,
            "pic1": photo1,
            "pic2": photo2,
            "pic3": photo3,
            "deep": deepclean,
            "cabinet": insideCabinet,
            "fridge": insideFridge,
            "oven": insideOven,
            "laundry": laundry,
            "windows": window,
            "rooms": allrooms,
            "area": area,
            "notes": notes,
            "price": totalPrice,
            "status": status
        ]
        
        Alamofire.request(URL_StartBidding, method: .post, parameters: parameters, encoding:URLEncoding.queryString, headers: nil).responseJSON {
            (response) in //Reponse is a temporary Variable where we get the result . we can write anything
            guard let data = response.data else{return}
            let json: JSON
            do{
                json = try JSON(data: data)
                print("Json Bidding Data = \(json)")
                let bidID = json[0]["id"].intValue
                Extras.singleton.tempBidID = bidID // storing temporary BID ID
                self.sendingOfferBid(id: bidID, completion: { (success) in
                    if(success){
                        print("\(bidID) :sendding offer bidding is successful")
                    }else{
                        print("\(bidID) :sendding offer bidding is NOTsuccessful")
                    }
                })
                
                completion(true)
            }
            catch
            {
                if response.result.error == nil{
                    completion(true)
                }
                else{
                    completion(false)
                    debugPrint(response.result.error as Any)
                }
            }
            
        }
        
    }
    
    
// sending bidding offer sent
    
    func sendingOfferBid(id: Int, completion: @escaping CompletionHanlder) {
        let parameters: Parameters = [
            "bid": id
        ]
        Alamofire.request(URL_BiddingOffer, method: .post, parameters: parameters, encoding:URLEncoding.queryString, headers: nil).responseJSON {
            
            (response) in //Reponse is a temporary Variable where we get the result . we can write anything
            guard let data = response.data else{return}
            let json: JSON
            do{

                json = try JSON(data: data)
                print("Json Offer Data = \(json)")
                completion(true)
                
            }
            catch
            {
                if response.result.error == nil{
                    completion(true)
                }
                else{
                    completion(false)
                    debugPrint(response.result.error as Any)
                }
            }
            
        }
        
    }
    
// GETTING OFFERS DATA FROM THE API
    
    func getOffersData(id: Int, completion: @escaping CompletionHanlder) {
        let parameters: Parameters = [
            "uid": id
        ]
        Alamofire.request(URL_GetOfferRequest, method: .get, parameters: parameters, encoding:URLEncoding.queryString, headers: nil).responseJSON {
            
            (response) in //Reponse is a temporary Variable where we get the result . we can write anything
            guard let data = response.data else{return}
            let json: JSON
            do{
                
                json = try JSON(data: data)
                print("Json getting Offer Data = \(json)")
                
                for i in 0..<json.count{
                    var stringObj = [String]()
                    let obj = BiddingDataModel()
                    obj.bidID = json[i]["id"].intValue
                    obj.day = json[i]["day"].intValue
                    obj.month = json[i]["month"].intValue
                    obj.price = json[i]["price"].intValue
                    obj.totalOffers = json[i]["total"].intValue
                    obj.deepclean = json[i]["deep"].intValue
                    obj.insidecabinet = json[i]["cabinets"].intValue
                    obj.insidefridge = json[i]["fridge"].intValue
                    obj.insideoven = json[i]["oven"].intValue
                    obj.laundry = json[i]["laundry"].intValue
                    obj.InteriorWindow = json[i]["windows"].intValue
                    
                    if(obj.deepclean! >= 1){
                        stringObj.append("Deep")
                        //BiddingDataModel.instance.OfferDetails.append("Deep")
                    }
                    if(obj.insidecabinet! >= 1){
                        stringObj.append("Inside Cabinet")
                        //BiddingDataModel.instance.OfferDetails.append("Inside Cabinet")
                    }
                    if(obj.insidefridge! >= 1){
                        stringObj.append("Inside Fridge")
                        //BiddingDataModel.instance.OfferDetails.append("Inside Fridge")
                    }
                    if(obj.insideoven! >= 1){
                        stringObj.append("Inside Oven")
                        //BiddingDataModel.instance.OfferDetails.append("Inside Oven")
                    }
                    if(obj.laundry! >= 1){
                        stringObj.append("Laundry")
                        //BiddingDataModel.instance.OfferDetails.append("Laundry")
                    }
                    if(obj.InteriorWindow! >= 1){
                        stringObj.append("Interior Windows")
                        //BiddingDataModel.instance.OfferDetails.append("Interior Windows")
                    }
                    
                    BiddingDataModel.instance.DetailArray.append(stringObj)
                    BiddingDataModel.instance.biddingArray.append(obj)
                    
                }
                
                print("this is bid array count: \(BiddingDataModel.instance.biddingArray.count)")
//
//                BiddingDataModel.instance.bidID = json[0]["id"].intValue
//                BiddingDataModel.instance.day = json[0]["day"].intValue
//                BiddingDataModel.instance.month = json[0]["month"].intValue
//                BiddingDataModel.instance.price = json[0]["price"].intValue
//                BiddingDataModel.instance.totalOffers = json[0]["total"].intValue
//                BiddingDataModel.instance.deepclean = json[0]["deep"].intValue
//                BiddingDataModel.instance.insidecabinet = json[0]["cabinets"].intValue
//                BiddingDataModel.instance.insidefridge = json[0]["fridge"].intValue
//                BiddingDataModel.instance.insideoven = json[0]["oven"].intValue
//                BiddingDataModel.instance.laundry = json[0]["laundry"].intValue
//                BiddingDataModel.instance.InteriorWindow = json[0]["windows"].intValue
                
                completion(true)
                
            }
            catch
            {
                if response.result.error == nil{
                    completion(true)
                }
                else{
                    completion(false)
                    debugPrint(response.result.error as Any)
                }
            }
            
        }
        
    }
    
    
// Cancel bidding offer
    
    func CancelBidRequest(id: Int, completion: @escaping CompletionHanlder) {
        let parameters: Parameters = [
            "bid": id
        ]
        Alamofire.request(URL_cancelRequest, method: .post, parameters: parameters, encoding:URLEncoding.queryString, headers: nil).responseJSON {
            
            (response) in //Reponse is a temporary Variable where we get the result . we can write anything
            guard let data = response.data else{return}
            let json: JSON
            do{
                
                json = try JSON(data: data)
                print("Json Cancel Offer Data = \(json)")
                completion(true)
                
            }
            catch
            {
                if response.result.error == nil{
                    completion(true)
                }
                else{
                    completion(false)
                    debugPrint(response.result.error as Any)
                }
            }
            
        }
        
    }
    
    
    // sid=4&cid=5&bid=6&receiver=Ahtasham&notification=525&type=string
    func insertNotificationInBidding(serviceProviderID: Int, cliendId: Int, biddID: Int, receiver: String, notification: String, type: String, completion: @escaping CompletionHanlder) {
        let parameters: Parameters = [
            "sid": serviceProviderID,
            "cid": cliendId,
            "bid": biddID,
            "receiver": receiver,
            "notification": notification,
            "type": type
        ]
        Alamofire.request(URL_insert_Notification, method: .post, parameters: parameters, encoding:URLEncoding.queryString, headers: nil).responseJSON {
            
            (response) in //Reponse is a temporary Variable where we get the result . we can write anything
            guard let data = response.data else{return}
            let json: JSON
            do{
                
                json = try JSON(data: data)
                print("Json Insert Notification Data = \(json)")
                completion(true)
                
            }
            catch
            {
                if response.result.error == nil{
                    completion(true)
                }
                else{
                    completion(false)
                    debugPrint(response.result.error as Any)
                }
            }
            
        }
        
    }
    
    
    // getting OFFERS data (client side)
    
    func gettingAllOffersDataUnderRequests(bidID: Int, completion: @escaping CompletionHanlder){
        
        let parameters: Parameters = [
            
            "id":bidID
            
        ]
        
        Alamofire.request(URL_getOffersData_Requests, method: .get, parameters: parameters, encoding:URLEncoding.queryString, headers: nil).responseJSON {
            (response) in //Reponse is a temporary Variable where we get the result . we can write anything
            guard let data = response.data else{return}
            let json: JSON
            do{
                
                json = try JSON(data: data)
                print("Json GETTING TOTAL OFFERS DATA = \(json)")
                
                // ================ for looop ==================
                
                for i in 0..<json.count{
                    
                    let obj = offersDataModel()
                    obj.offerid = json[i]["id"].intValue
                    obj.name = json[i]["name"].stringValue
                    obj.image = json[i]["image"].stringValue
                    obj.hourlyrate = json[i]["hourlyrate"].intValue
                    obj.jobs = json[i]["jobs"].intValue
                    obj.rating = json[i]["rating"].intValue
                    obj.review = json[i]["reviews"].intValue
                    obj.bidID = json[i]["bidid"].intValue
                    obj.SPID = json[i]["spid"].intValue
                    obj.price = json[i]["price"].intValue
                    
                    offersDataModel.instance.totaloffersData.append(obj)
                    
                }
                
                
                completion(true)
            }
            catch
            {
                if response.result.error == nil{
                    completion(true)
                }
                else{
                    completion(false)
                    debugPrint(response.result.error as Any)
                }
            }
        }
    }
    
    
    
//  =================================================================
//  ==================  SERVICE PROVIDER APIS =======================
//  =================================================================
    
    
    func SPloginUser(email: String, password: String, completion: @escaping CompletionHanlder) {
        
        let parameters: Parameters = [
            
            "email":email,
            "password":password
            
        ]
        Alamofire.request(URL_SPLogin, method: .get, parameters: parameters, encoding:URLEncoding.queryString, headers: nil).responseString {
            (response) in //Reponse is a temporary Variable where we get the result . we can write anything
            if response.result.error == nil{
                
                
                guard let data = response.data else{return}
                let json: JSON
                do{
                    json = try JSON(data: data)
                    print("Getting data from Service Provider Login Api \(json)")
                    
                    let preferences = UserDefaults.standard
                    
                    
                    
                    
                    // model initializer
                    ServiceProviderUser.instance.id = json[0]["id"].stringValue
                    preferences.set(ServiceProviderUser.instance.id, forKey: "SPid")
                    
                    
                    
                    ServiceProviderUser.instance.name = json[0]["name"].stringValue
                    preferences.set(ServiceProviderUser.instance.name, forKey: "name")
                    
                    
                    
                    ServiceProviderUser.instance.email = json[0]["email"].stringValue
                    preferences.set(ServiceProviderUser.instance.email, forKey: "email")
                    
                    
                    
                    ServiceProviderUser.instance.password = json[0]["password"].stringValue
                    preferences.set(ServiceProviderUser.instance.password, forKey: "password")
                    
                    
                    ServiceProviderUser.instance.experience = json[0]["experience"].stringValue
                    preferences.set(ServiceProviderUser.instance.experience, forKey: "experience")
                    
                    
                    ServiceProviderUser.instance.contact = json[0]["contact"].stringValue
                    preferences.set(ServiceProviderUser.instance.contact, forKey: "contact")
                    
                    
                    
                    ServiceProviderUser.instance.document = json[0]["document"].stringValue
                    preferences.set(User.userInstance.fcmToken, forKey: "document")
                    
                    
                    ServiceProviderUser.instance.zipcode = json[0]["zipcode"].stringValue
                    preferences.set(ServiceProviderUser.instance.zipcode, forKey: "zipcode")
                    
                    
                    ServiceProviderUser.instance.bio = json[0]["bio"].stringValue
                    preferences.set(ServiceProviderUser.instance.bio, forKey: "bio")
                    
                    
                    ServiceProviderUser.instance.hourlyrate = json[0]["hourlyrate"].stringValue
                    preferences.set(ServiceProviderUser.instance.hourlyrate, forKey: "hourlyrate")
                    
                    
                    ServiceProviderUser.instance.image = json[0]["image"].stringValue
                    preferences.set(ServiceProviderUser.instance.image, forKey: "image")
                    
                    // username.png to complete ImageURL
                    let userimage = json[0]["image"].stringValue
                    let imageURL = "\(s3_baseURL)\(userimage)"
                    print("complete image URL: \(imageURL)")
                    ServiceProviderUser.instance.imageURL = imageURL
                    preferences.set(ServiceProviderUser.instance.imageURL, forKey: "imageURL")
                    
                    // =========================================================================================================
                    
                    if(ServiceProviderUser.instance.name != ""){
                        
                        self.loginstatus = "successsful"
                        completion(true)
                    }else{
                        self.loginstatus = "not success"
                        completion(true)
                    }
                    
                    
                    self.didsave(preferences: preferences)
                }
                catch
                {
                    if response.result.error == nil{
                        completion(true)
                    }
                    else{
                        completion(false)
                        debugPrint(response.result.error as Any)
                    }
                }
                
                completion(true)
            }
            else{
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    
    func ServiceProviderSignUP(name: String, email: String, password: String, experience: String, contact: String, document: String, zipcode: String, bio: String, completion: @escaping CompletionHanlder) {
        
        let parameters: Parameters = [
            "name": name,
            "email":email,
            "password":password,
            "experience": experience,
            "contact": contact,
            "document": document,
            "zipcode": zipcode,
            "bio": bio
        ]
        
        Alamofire.request(URL_SPSignUP, method: .post, parameters: parameters, encoding:URLEncoding.queryString, headers: nil).responseJSON {
            (response) in //Reponse is a temporary Variable where we get the result . we can write anything
            guard let data = response.data else{return}
            let json: JSON
            do{
                json = try JSON(data: data)
                print("Json data = \(json)")
                // =========================================
                let spid = json[0]["id"].intValue
                
                self.InsertDefaultRating(serviceProviderID: spid, jobs: 0, rating: 0, review: 0, completion: { (success) in
                    if(success){
                        print("inserting")
                    }else{
                        print("not inserting")
                    }
                })
                
                completion(true)
            }
            catch
            {
                if response.result.error == nil{
                    completion(true)
                }
                else{
                    completion(false)
                    debugPrint(response.result.error as Any)
                }
            }
        }
    }
    
    
    func ServiceProviderUpdateProfile(name: String, email: String, mobilephone: String, hourlyrate: Int, bio: String, image: String, completion: @escaping CompletionHanlder){
        
        let parameters: Parameters = [
            "name": name,
            "email":email,
            "mobilephone": mobilephone,
            "hourlyrate": hourlyrate,
            "bio": bio,
            "image": image
        ]
        
        Alamofire.request(URL_SPupdateProfile, method: .post, parameters: parameters, encoding:URLEncoding.queryString, headers: nil).responseJSON {
            (response) in //Reponse is a temporary Variable where we get the result . we can write anything
            guard let data = response.data else{return}
            let json: JSON
            do{
                json = try JSON(data: data)
                print("Json data = \(json[0]["error"])")
                if(self.JsonResult(json: json)){
                    print("Data not updated")
                }else{
                    print("Data updated Successfull")
                }
                completion(true)
            }
            catch
            {
                if response.result.error == nil{
                    completion(true)
                }
                else{
                    completion(false)
                    debugPrint(response.result.error as Any)
                }
            }
            
        }
        
    }
    
    // Insert Default Rating   spid=4&cid=4&jobs=ahtasham&rating=5start
    
    func InsertDefaultRating(serviceProviderID: Int, jobs: Int, rating: Int, review: Int, completion: @escaping CompletionHanlder){
        
        let parameters: Parameters = [
            "spid": serviceProviderID,
            "jobs": jobs,
            "rating": rating,
            "review": review
        ]
        
        Alamofire.request(URL_ServiceProviderInsertRating, method: .post, parameters: parameters, encoding:URLEncoding.queryString, headers: nil).responseJSON {
            (response) in //Reponse is a temporary Variable where we get the result . we can write anything
            guard let data = response.data else{return}
            let json: JSON
            do{
                
                json = try JSON(data: data)
                print("Json INSERT RATING ID = \(json)")
                completion(true)
                
            }
            catch
            {
                if response.result.error == nil{
                    completion(true)
                }
                else{
                    completion(false)
                    debugPrint(response.result.error as Any)
                }
            }
            
        }
        
    }
    
    
    // getting service provider data
    
    func gettingServiceProviderData(completion: @escaping CompletionHanlder){
        
        Alamofire.request(URL_getServiceProviderData, method: .get, encoding:URLEncoding.queryString, headers: nil).responseJSON {
            (response) in //Reponse is a temporary Variable where we get the result . we can write anything
            guard let data = response.data else{return}
            let json: JSON
            do{
                
                json = try JSON(data: data)
                print("Json GETTING SERVICE PROVIDER DATA = \(json)")
                
                // ================ for looop ==================
                
                for i in 0..<json.count{

                    let obj = ChooseProviderModel()
                    obj.rating = json[i]["rating"].intValue
                    obj.spID = json[i]["id"].intValue
                    obj.image = json[i]["image"].stringValue
                    obj.hourlyrate = json[i]["hourlyrate"].intValue
                    obj.jobs = json[i]["jobs"].intValue
                    obj.review = json[i]["reviews"].intValue
                    obj.name = json[i]["name"].stringValue

                    ChooseProviderModel.instance.chooseProviderArray.append(obj)
                    
                }
                
                
                completion(true)
            }
            catch
            {
                if response.result.error == nil{
                    completion(true)
                }
                else{
                    completion(false)
                    debugPrint(response.result.error as Any)
                }
            }
        }
    }
    
}
