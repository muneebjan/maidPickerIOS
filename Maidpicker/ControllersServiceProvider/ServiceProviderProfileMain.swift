//
//  ServiceProviderProfileMain.swift
//  Maidpicker
//
//  Created by Apple on 29/10/2018.
//  Copyright © 2018 devstop. All rights reserved.
//

import UIKit

class ServiceProviderProfileMain: UIViewController {

// UI-OUTLETS
    
    @IBOutlet weak var NameTF: UITextField!
    @IBOutlet weak var ContactTF: UITextField!
    @IBOutlet weak var EmailTF: UITextField!
    @IBOutlet weak var zipcodeTF: UITextField!
    @IBOutlet weak var profileImage: UIImageView!
    
// VIEW WILL APPEAR
    override func viewWillAppear(_ animated: Bool) {
        convertImageURLtoUIimage()
        dataTextFields()
    }
    
// VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
    }

// OTHER FUNCTIONS

    func convertImageURLtoUIimage() {
        print("starting URL: \(ServiceProviderUser.instance.imageURL)")
        if let imageurl = ServiceProviderUser.instance.imageURL{
            let url = URL(string: imageurl)
            guard let data = try? Data(contentsOf: url!)else{return}
            ServiceProviderUser.instance.spuserImage = UIImage(data: data)
        }
    }
    
    func dataTextFields() {
        //self.convertImageURLtoUIimage()
        if let image = ServiceProviderUser.instance.spuserImage{
            
            self.profileImage.contentMode = .scaleAspectFill
            self.profileImage.layer.cornerRadius = (self.profileImage.frame.size.width)/2
            self.profileImage.clipsToBounds = true
            self.profileImage.image = image
            
        }
        
        if let name = ServiceProviderUser.instance.name{
            NameTF.placeholder = name
        }
        if let contact = ServiceProviderUser.instance.contact{
            ContactTF.placeholder = contact
        }
        if let email = ServiceProviderUser.instance.email{
            EmailTF.placeholder = email
        }
        if let zipcode = ServiceProviderUser.instance.zipcode{
            zipcodeTF.placeholder = zipcode
        }
        
    }
 
// UNWIND SEGUES
    
    @IBAction func unwindTo_ServiceProvider_ProfileMain(unwind: UIStoryboardSegue){
        
    }
    
}
