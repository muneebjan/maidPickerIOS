//
//  HomeViewController.swift
//  Maidpicker
//
//  Created by Apple on 17/09/2018.
//  Copyright © 2018 devstop. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, sendingData {

  
    // uiOutlets

    @IBOutlet weak var taskAddress: UILabel!
    @IBOutlet weak var When: UILabel!
    @IBOutlet weak var TaskSize: UILabel!
    @IBOutlet weak var HowOften: UILabel!
    @IBOutlet weak var Extras: UILabel!
    @IBOutlet weak var SpecialServices: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func gotoHome_When(_ sender: Any) {
        
        let VC = storyboard?.instantiateViewController(withIdentifier: "Home_WhenVc") as! Home_When_MainVC
        VC.delegate = self
        self.navigationController?.pushViewController(VC, animated: true)
        
    }
    
    @IBAction func gotoHome_TaskAddress(_ sender: Any) {
        
        let VC = storyboard?.instantiateViewController(withIdentifier: "Home_TaskAddress") as! Home_TaskAddressVC
        VC.delegate = self
        self.navigationController?.pushViewController(VC, animated: true)
        
    }
    
    func settingTime(startDate: String, endDate: String) {
        When.text = "When: "+startDate+"-"+endDate
    }
    
    @IBAction func unwindTo_HomeMain(unwind: UIStoryboardSegue){
        
    }
    
}

extension HomeViewController: dataprotocol{
    func settingTime(address: String) {
        taskAddress.text = address
    }
    
    
}

