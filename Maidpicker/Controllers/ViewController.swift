//
//  ViewController.swift
//  Maidpicker
//
//  Created by Apple on 05/09/2018.
//  Copyright © 2018 devstop. All rights reserved.
//

import UIKit
//import RealmSwift

class ViewController: UIViewController {

//    var realmobject = RealmUser()
    
    override func viewDidLoad() {
        super.viewDidLoad()



        // model initializer FROM SHAREDPREFERENCES
        
        let preferences = UserDefaults.standard
        //print(preferences.string(forKey: "id"))
        
        if(preferences.string(forKey: "id") != nil)
        {
            
            User.userInstance.Userid = preferences.string(forKey: "id")
            User.userInstance.name = preferences.string(forKey: "name")
            User.userInstance.email = preferences.string(forKey: "email")
            User.userInstance.password = preferences.string(forKey: "password")
            User.userInstance.mobilephone = preferences.string(forKey: "mobilephone")
            User.userInstance.fcmToken = preferences.string(forKey: "fcmToken")
            User.userInstance.imageURL = preferences.string(forKey: "imageURL")
            User.userInstance.zipcode = preferences.string(forKey: "zipcode")
            //print(User.userInstance.imageURL)
            

            
            print("this is TOKEN: \(User.userInstance.fcmToken)")
            
            
            let url = URL(string: User.userInstance.imageURL!)
            if let data = try? Data(contentsOf: url!)
            {
                User.userInstance.userImage = UIImage(data: data)
            }
            
            let Mainvc = self.storyboard?.instantiateViewController(withIdentifier: "tabBarViewController") as! tabBarViewController
            DispatchQueue.main.async {
                print("Client User ID Found")
                self.present(Mainvc, animated: true, completion: nil)
            }

            
            
        }
        else{
            print("Client Side ID NOT EXISTING"
            )
        }
// =========================================================================================================
// // ==============================SERVICE PROVIDER USERDEFAULTS (AUTO SIGNIN)// ==========================
// =========================================================================================================
        
        if(preferences.string(forKey: "SPid") != nil)
        {
            
            ServiceProviderUser.instance.id = preferences.string(forKey: "SPid")
            ServiceProviderUser.instance.name = preferences.string(forKey: "name")
            ServiceProviderUser.instance.email = preferences.string(forKey: "email")
            ServiceProviderUser.instance.password = preferences.string(forKey: "password")
            ServiceProviderUser.instance.contact = preferences.string(forKey: "mobilephone")
            ServiceProviderUser.instance.zipcode = preferences.string(forKey: "zipcode")
            ServiceProviderUser.instance.document = preferences.string(forKey: "document")
            ServiceProviderUser.instance.experience = preferences.string(forKey: "experience")
            ServiceProviderUser.instance.hourlyrate = preferences.string(forKey: "hourlyrate")
            ServiceProviderUser.instance.image = preferences.string(forKey: "image")
            ServiceProviderUser.instance.imageURL = preferences.string(forKey: "imageURL")
            
            //print("this is imageURL: \(ServiceProviderUser.instance.imageURL)")
            
            if let imageurl = ServiceProviderUser.instance.imageURL{
                let url = URL(string: imageurl)
                if let data = try? Data(contentsOf: url!)
                {
                    ServiceProviderUser.instance.spuserImage = UIImage(data: data)
                }
            }else{
                print("Image not found")
            }
    
            let Mainvc = self.storyboard?.instantiateViewController(withIdentifier: "ServiceProviderTabBarVC") as! ServiceProvidertabBarVC
            DispatchQueue.main.async {
                print("Service Provider User ID Found")
                self.present(Mainvc, animated: true, completion: nil)
            }
            
        }
        else{
            print("Service Provider Side ID NOT EXISTING"
            )
        }
        
        
// =========================================================================================================
// ============================ END (SERVICE PROVIDER USERDEFAULTS (AUTO SIGNIN)) ==========================
// =========================================================================================================
        
        
    }

    @IBAction func ClientBtnPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "LoginSignupPage", sender: self)
    }
    
    @IBAction func ServiceBtnPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "gotoLoginServiceProvider", sender: self)
    }
    
    @IBAction func unwindfromLoginScreen(unwind: UIStoryboardSegue){
        
    }
    
}
extension UIViewController {
    class func displaySpinner(onView : UIView) -> UIView {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(activityIndicatorStyle: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        return spinnerView
    }
    
    class func removeSpinner(spinner :UIView) {
        DispatchQueue.main.async {
            spinner.removeFromSuperview()
        }
    }
}

