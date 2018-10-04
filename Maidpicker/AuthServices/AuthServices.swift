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
                    
                    
                    
                    User.userInstance.fcmToken = json[0]["fcm_token"].stringValue
                    preferences.set(User.userInstance.fcmToken, forKey: "fcm_token")
                    
                    
                    
                    User.userInstance.image = json[0]["image"].stringValue
                    preferences.set(User.userInstance.image, forKey: "image")
                    
                    
                    User.userInstance.zipcode = json[0]["zipcode"].stringValue
                    preferences.set(User.userInstance.zipcode, forKey: "zipcode")
                    
//=================================== convert imageURL to UIImage: ========================================
                    
                    if let userimage = User.userInstance.image{
                        let imageURL = "\(s3_baseURL)\(userimage)"
                        print("complete image URL: \(imageURL)")
                        preferences.set(imageURL, forKey: "imageURL")
                        let url = URL(string: imageURL)
                        if let data = try? Data(contentsOf: url!)
                        {
                            User.userInstance.userImage = UIImage(data: data)
                        }
                    }
                    else{
                        return
                    }

                    
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
    
    func add_Address(uid: String, address1: String, address2: String, rooms: String, washrooms: String, area: String, completion: @escaping CompletionHanlder){
        
        let parameters: Parameters = [
            "uid": uid,
            "address1":address1,
            "address2": address2,
            "rooms": rooms,
            "washrooms": washrooms,
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
    
    
}
