//
//  SettingCenterViewController.swift
//  Maidpicker
//
//  Created by Apple on 19/09/2018.
//  Copyright © 2018 devstop. All rights reserved.
//

import UIKit

class SettingCenterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    
    
    @IBAction func SignoutBtnPressed(_ sender: Any) {
        
        print("Signout button pressed")
        UserDefaults.standard.set(nil, forKey: "id")
        UserDefaults.standard.synchronize()
        
        self.performSegue(withIdentifier: "gotoViewController", sender: self)
        
    }
    
    // unwind segue
    @IBAction func unwindTo_SettingCenter(unwind: UIStoryboardSegue){
        
    }

}
