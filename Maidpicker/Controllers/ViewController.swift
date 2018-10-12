//
//  ViewController.swift
//  Maidpicker
//
//  Created by Apple on 05/09/2018.
//  Copyright © 2018 devstop. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()



        // model initializer FROM SHAREDPREFERENCES
        
        let preferences = UserDefaults.standard
        print(preferences.string(forKey: "id"))
        
        if(preferences.string(forKey: "id") != nil)
        {
            
            User.userInstance.Userid = preferences.string(forKey: "id")
            User.userInstance.name = preferences.string(forKey: "name")
            User.userInstance.email = preferences.string(forKey: "email")
            User.userInstance.password = preferences.string(forKey: "password")
            User.userInstance.mobilephone = preferences.string(forKey: "mobilephone")
            User.userInstance.fcmToken = preferences.string(forKey: "fcm_token")
            User.userInstance.image = preferences.string(forKey: "image")
            User.userInstance.zipcode = preferences.string(forKey: "zipcode")
            print("0: here we are")
            guard let imageURL = preferences.string(forKey: "imageURL")else {
                print("error here 111")
                return
            }
            print("1: string:  \(imageURL)")
            let url = URL(string: imageURL)
            guard let data = try? Data(contentsOf: url!)else{return}
            User.userInstance.userImage = UIImage(data: data)
            print("2; successfull")
            
            

            
            print("this is TOKEN: \(User.userInstance.fcmToken)")
            
            
//            let url = URL(string: User.userInstance.imgurl!)
//            if let data = try? Data(contentsOf: url!)
//            {
//
//                User.userInstance.userImage = UIImage(data: data)
//            }
            
            let Mainvc = self.storyboard?.instantiateViewController(withIdentifier: "tabBarViewController") as! tabBarViewController
            DispatchQueue.main.async {
                self.present(Mainvc, animated: true, completion: nil)
            }

            
            
        }
        else{
            print("NOT EXISTING"
            )
        }
        
        
        
    }

    @IBAction func ClientBtnPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "LoginSignupPage", sender: self)
    }
    
    @IBAction func ServiceBtnPressed(_ sender: Any) {
        //self.performSegue(withIdentifier: "LoginSignupPage", sender: self)
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

