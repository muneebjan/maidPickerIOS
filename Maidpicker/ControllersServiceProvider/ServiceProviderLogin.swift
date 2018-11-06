//
//  ServiceProviderLogin.swift
//  Maidpicker
//
//  Created by Apple on 23/10/2018.
//  Copyright © 2018 devstop. All rights reserved.
//

import UIKit

class ServiceProviderLogin: UIViewController {

    @IBOutlet weak var EmailTextfield: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    
    
    @IBAction func SignupBtnPressed(_ sender: Any) {
        print("Go to Signup Button")
        self.performSegue(withIdentifier: "toSignupServiceProvider", sender: self)
    }
    
    @IBAction func LoginBtnPressed(_ sender: Any) {
        
        if let email = EmailTextfield.text, let password = passTextField.text{
            
            if ((EmailTextfield.text?.isEmpty)! || (passTextField.text?.isEmpty)!){
                displayMyAlertMessage(userMessage: "All fields are required")
                //display alert message
                
                return
                
            }else{
                
                AuthServices.instance.SPloginUser(email: email, password: password) { (success) in
                    if (success){
                        if(AuthServices.instance.loginstatus == "successsful"){
                            
                            let homevc = self.storyboard?.instantiateViewController(withIdentifier: "ServiceProviderTabBarVC") as! ServiceProvidertabBarVC
                            DispatchQueue.main.async {
                                self.present(homevc, animated: true, completion: nil)
                            }
                            
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
    @IBAction func unwindToServiceProviderLogin(unwind: UIStoryboardSegue){
        
    }
    
}
