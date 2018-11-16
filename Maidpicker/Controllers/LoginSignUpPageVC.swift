//
//  LoginSignUpPageVC.swift
//  Maidpicker
//
//  Created by Apple on 07/09/2018.
//  Copyright © 2018 devstop. All rights reserved.
//

import UIKit

class LoginSignUpPageVC: UIViewController {
    @IBOutlet weak var EmailTextfield: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    
    
    @IBAction func SignupBtnPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "To_SigupVC", sender: self)
    }
    @IBAction func LoginBtnPressed(_ sender: Any) {
        
        if let email = EmailTextfield.text, let password = passTextField.text{
            
            if ((EmailTextfield.text?.isEmpty)! || (passTextField.text?.isEmpty)!){
                displayMyAlertMessage(userMessage: "All fields are required")
                //display alert message
                
                return
                
            }else{

                AuthServices.instance.loginUser(email: email, password: password) { (success) in
                    if (success){
                        if(AuthServices.instance.loginstatus == "successsful"){
                            
                            if let fcmtoken = UserDefaults.standard.string(forKey: "fcmToken"){
                                User.userInstance.fcmToken = fcmtoken
                                AuthServices.instance.RegisterDeviceForNotification(userid: User.userInstance.Userid!, token: fcmtoken, completion: { (success) in
                                    if(success){
                                        print("Device Registered For FCM-TOKEN")
                                        let homevc = self.storyboard?.instantiateViewController(withIdentifier: "tabBarViewController") as! tabBarViewController
                                        DispatchQueue.main.async {
                                            self.present(homevc, animated: true, completion: nil)
                                        }
                                    }else{
                                        print("fcmToken not registered")
                                    }
                                })
                            }

//                            let homevc = self.storyboard?.instantiateViewController(withIdentifier: "tabBarViewController") as! tabBarViewController
//                            DispatchQueue.main.async {
//                                self.present(homevc, animated: true, completion: nil)
//                            }
                            
                        }else{
                            self.displayMyAlertMessage(userMessage: "Incorrect Email or Password")
                        }
                    }else{
                        self.displayMyAlertMessage(userMessage: "Email not Exits")
                    }
                }
                
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    //  METHOD TO DISABLE KEYBOARD
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    

    
    func displayMyAlertMessage(userMessage: String) {
        var myalert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        myalert.addAction(okAction)
        present(myalert, animated: true, completion: nil)
        
    }
    
    
    
    // unwind
    @IBAction func unwindfromSignupScreen(unwind: UIStoryboardSegue){
        
    }

}
