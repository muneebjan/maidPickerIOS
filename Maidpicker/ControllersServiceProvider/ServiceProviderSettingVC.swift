//
//  ServiceProviderSettingVC.swift
//  Maidpicker
//
//  Created by Apple on 26/10/2018.
//  Copyright © 2018 devstop. All rights reserved.
//

import UIKit

class ServiceProviderSettingVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
    @IBAction func LeaveBtnPressed(_ sender: Any) {
        
        print("Signout button pressed")
        UserDefaults.standard.set(nil, forKey: "SPid")
        UserDefaults.standard.synchronize()
        
        self.performSegue(withIdentifier: "gotoViewControllerMain", sender: self)
        
    }
    
}
