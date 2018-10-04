//
//  RegistrationVC.swift
//  Maidpicker
//
//  Created by Apple on 07/09/2018.
//  Copyright © 2018 devstop. All rights reserved.
//

import UIKit
import ValidationComponents

class RegistrationVC: UIViewController {

    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var phonenumber: UITextField!
    @IBOutlet weak var zipcodeTextfield: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    @IBAction func SignupBtnPressed(_ sender: Any) {
        
        guard let name = nameTextfield.text?.trimmingCharacters(in: .whitespacesAndNewlines),
            let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
            let password = password.text?.trimmingCharacters(in: .whitespacesAndNewlines),
            let phonenumber = phonenumber.text?.trimmingCharacters(in: .whitespacesAndNewlines),
            let zipcode = zipcodeTextfield.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            
            else {
                print("Form is not Valid")
                return
            }

        AuthServices.instance.checkEmail(email: email) { (success) in
            if(success){
                print(AuthServices.instance.checkemailstatus)
                if (AuthServices.instance.checkemailstatus == "Existtss"){
                    self.displayMyAlertMessage(userMessage: "email already Exists")
                    
                }
                else{
                    
                    if(name == nil || name == ""){
                        self.displayMyAlertMessage(userMessage: "name is Empty")
                        return
                    }
                    if(email == nil || email == ""){
                        self.displayMyAlertMessage(userMessage: "email is Empty")
                        return
                    }
//                    let email = email
//                    let rule = EmailValidationPredicate()
//                    if(!rule.evaluate(with: email)){
//                        self.displayMyAlertMessage(userMessage: "Email not Valid")
//                        return
//                    }
                    
                    if(password == nil || password == ""){
                        self.displayMyAlertMessage(userMessage: "password is Empty")
                        return
                    }
                    if(phonenumber == nil || phonenumber == ""){
                        self.displayMyAlertMessage(userMessage: "phonenumber is Empty")
                        return
                    }
                    if(zipcode == nil || zipcode == ""){
                        self.displayMyAlertMessage(userMessage: "zipcode is Empty")
                        return
                    }
                    
                    
                    AuthServices.instance.registerUser(name: name, email: email, password: password, mobilephone: phonenumber, zipcode: zipcode, completion: { (success) in
                        if(success){
                            print("User Register Successfull")
                            self.dismiss(animated: true, completion: nil)
                        }
                    })
                    
                }
            }
        }

    }
    
    func displayMyAlertMessage(userMessage: String) {
        var myalert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
    
        myalert.addAction(okAction)
        present(myalert, animated: true, completion: nil)
    
    }
    //  METHOD TO DISABLE KEYBOARD
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
