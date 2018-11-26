//
//  ServiceProviderHomeMain.swift
//  Maidpicker
//
//  Created by Apple on 23/11/2018.
//  Copyright © 2018 devstop. All rights reserved.
//

import UIKit

class ServiceProviderHomeMain: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func BidsPressed(_ sender: Any) {
        let VC = storyboard?.instantiateViewController(withIdentifier: "SP_Home_Bid") as! ServiceProviderHome_Bid
        //VC.delegate = self
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    @IBAction func QuickJobsPressed(_ sender: Any) {
        let VC = storyboard?.instantiateViewController(withIdentifier: "SP_Home_QuickJobs") as! ServiceProviderHome_QuickJob
        //VC.delegate = self
        self.navigationController?.pushViewController(VC, animated: true)
    }
}
