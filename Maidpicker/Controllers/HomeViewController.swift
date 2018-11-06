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
    
    @IBAction func gotoHome_HowOften(_ sender: Any) {
        
        let VC = storyboard?.instantiateViewController(withIdentifier: "Home_howOften") as! Home_HowOftenVC
        VC.delegate = self
        self.navigationController?.pushViewController(VC, animated: true)
        
    }
    
    @IBAction func gotoHome_Extras(_ sender: Any) {
        
        let VC = storyboard?.instantiateViewController(withIdentifier: "Home_Extras") as! Home_ExtrasVC
        VC.delegate = self
        self.navigationController?.pushViewController(VC, animated: true)
        
    }
    
    @IBAction func gotoHome_SpecialServices(_ sender: Any) {
        
        let VC = storyboard?.instantiateViewController(withIdentifier: "Home_SpecialServices") as! Home_SpecialServicesMainVC
        //VC.delegate = self
        self.navigationController?.pushViewController(VC, animated: true)
        
    }
    
    
    func settingTime(startDate: String, endDate: String) {
        When.text = "When: "+startDate+"-"+endDate
    }
    
    @IBAction func unwindTo_HomeMain(unwind: UIStoryboardSegue){
        
    }
    @IBAction func confirmButtonPressed(_ sender: Any) {
        print("confirm button Pressed")
        let VC = storyboard?.instantiateViewController(withIdentifier: "ServicesPage") as! ServicesVC
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
}

extension HomeViewController: dataprotocol, HowOftenProtocol, ExtasClassProtocol{
    func sendingDataExtra(data: [String]) {
        Extras.text = data.joined(separator: ", ")
    }
    

    
    func sendingData(data: String) {
        HowOften.text = data
    }
    
    func settingTime(address: String) {
        taskAddress.text = address
    }
    
    
}

