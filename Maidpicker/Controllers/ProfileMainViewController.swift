//
//  ProfileMainViewController.swift
//  Maidpicker
//
//  Created by Apple on 18/09/2018.
//  Copyright © 2018 devstop. All rights reserved.
//

import UIKit

class ProfileMainViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var contactTextfield: UITextField!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var zipTextfield: UITextField!
    @IBOutlet weak var profileImage: UIImageView!
    
    
    override func viewWillAppear(_ animated: Bool) {
        //viewDidLoad()
        
//        AuthServices.instance.loginUser(email: User.userInstance.email!, password: User.userInstance.password!) { (success) in
//            if(success){
//                self.dataTextFields()
//            }
//        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataTextFields()
    }
    
    func dataTextFields() {

        if let image = User.userInstance.userImage{
            
            self.profileImage.contentMode = .scaleAspectFill
            self.profileImage.layer.cornerRadius = (self.profileImage.frame.size.width)/2
            self.profileImage.clipsToBounds = true
            self.profileImage.image = image
            
        }
        
        if let name = User.userInstance.name{
            nameTextField.placeholder = name
        }
        if let contact = User.userInstance.mobilephone{
            contactTextfield.placeholder = contact
        }
        if let email = User.userInstance.email{
            emailTextfield.placeholder = email
        }
        if let zipcode = User.userInstance.zipcode{
            zipTextfield.placeholder = zipcode
        }
        
    }

    
    // unwind segue
    @IBAction func unwindTo_ProfileMain(unwind: UIStoryboardSegue){
        
    }

    @IBAction func LeaveBtnPressed(_ sender: Any) {
        
        print("Signout button pressed")
        UserDefaults.standard.set(nil, forKey: "id")
        UserDefaults.standard.synchronize()
        
        self.performSegue(withIdentifier: "gotoViewController", sender: self)
        
    }
    
}
