//
//  PasswordSettingVC.swift
//  Maidpicker
//
//  Created by Apple on 19/09/2018.
//  Copyright © 2018 devstop. All rights reserved.
//

import UIKit

class PasswordSettingVC: UIViewController {

    // OUTLETS
    
    @IBOutlet weak var OldPassword: UITextField!
    @IBOutlet weak var NewPassword: UITextField!
    @IBOutlet weak var ConfirmPassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        OldPassword.placeholder = User.userInstance.password
        
    }

    
    // ================ FUNCTIONS ================
    
    // display ALERT FUNCTION
    
    func displayMyAlertMessage(userMessage: String) {
        var myalert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        myalert.addAction(okAction)
        present(myalert, animated: true, completion: nil)
    }
        

        

    
    
    
    // ========= BUTTONS ACTIONS ============
    
    @IBAction func LeaveBtnPressed(_ sender: Any) {
        
        print("Signout button pressed")
        UserDefaults.standard.set(nil, forKey: "id")
        UserDefaults.standard.synchronize()
        
        self.performSegue(withIdentifier: "gotoViewController", sender: self)
        
    }
    
    
    
    @IBAction func PasswordUpdateBtn(_ sender: Any) {
        
        print("Update Button Pressed")
        
        let oldPassword = OldPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let newpassword = NewPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let confirmpassword = ConfirmPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if (oldPassword != User.userInstance.password) {
            self.displayMyAlertMessage(userMessage: "Old Password is Incorrect")
        }else if(newpassword != confirmpassword){
            self.displayMyAlertMessage(userMessage: "Password Mismatch Error")
        }else{
            
            AuthServices.instance.updatePassWord(email: User.userInstance.email!, password: newpassword!) { (success) in
                if(success){
                    self.performSegue(withIdentifier: "gotoSettingCenterAfterUpdatePassword", sender: self)
                    //self.displayMyAlertMessage(userMessage: "Password Update Successfully")
                }else{
                    self.displayMyAlertMessage(userMessage: "Password API not successful")
                }
            }
            
        }
        
    }
    
    
    @IBAction func backBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //  METHOD TO DISABLE KEYBOARD
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
