//
//  Home_HowOftenVC.swift
//  Maidpicker
//
//  Created by Apple on 15/10/2018.
//  Copyright © 2018 devstop. All rights reserved.
//

import UIKit

protocol HowOftenProtocol {
    func sendingData(data: String)
}

class Home_HowOftenVC: UIViewController {

    @IBOutlet weak var weeklyLabel: UILabel!
    @IBOutlet weak var biweeklyLabel: UILabel!
    @IBOutlet weak var monthlyLabel: UILabel!
    @IBOutlet weak var justonceLabel: UILabel!
    @IBOutlet weak var weeklyButton: UIButton!
    @IBOutlet weak var biweeklyButton: UIButton!
    @IBOutlet weak var monthlyButton: UIButton!
    @IBOutlet weak var justonceButton: UIButton!
    
    var howoftendata: String?
    
    var isOn: Bool = false
    var biweeklyisOn: Bool = false
    var monthlyisOn: Bool = false
    var justOnceIsOn: Bool = false
    
    var delegate: HowOftenProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    @IBAction func weeklyPressed(_ sender: UIButton) {

        if(isOn == true){
            self.weeklyLabel.textColor = #colorLiteral(red: 0.6849097013, green: 0.8780232072, blue: 0.9137651324, alpha: 1)
            self.biweeklyLabel.textColor = #colorLiteral(red: 0.6849097013, green: 0.8780232072, blue: 0.9137651324, alpha: 1)
            self.monthlyLabel.textColor = #colorLiteral(red: 0.6849097013, green: 0.8780232072, blue: 0.9137651324, alpha: 1)
            self.justonceLabel.textColor = #colorLiteral(red: 0.6849097013, green: 0.8780232072, blue: 0.9137651324, alpha: 1)
            self.isOn = false
            self.biweeklyisOn = false
            self.monthlyisOn = false
            self.justOnceIsOn = false
        }else{
            self.weeklyLabel.textColor = #colorLiteral(red: 0.7709656358, green: 0.8703430295, blue: 0.5776815414, alpha: 1)
            self.biweeklyLabel.textColor = #colorLiteral(red: 0.6849097013, green: 0.8780232072, blue: 0.9137651324, alpha: 1)
            self.monthlyLabel.textColor = #colorLiteral(red: 0.6849097013, green: 0.8780232072, blue: 0.9137651324, alpha: 1)
            self.justonceLabel.textColor = #colorLiteral(red: 0.6849097013, green: 0.8780232072, blue: 0.9137651324, alpha: 1)
            self.isOn = true
            self.biweeklyisOn = false
            self.monthlyisOn = false
            self.justOnceIsOn = false
        }
        
        print("weeklybutton is = \(self.isOn)")
        print("Bi-Isweeklybutton is = \(self.biweeklyisOn)")
        print("Monthy-button is = \(self.monthlyisOn)")
        print("JustOnce-button is = \(self.justOnceIsOn)")
    }
    
    @IBAction func biWeeklyPressed(_ sender: UIButton) {
        
        if(isOn == true){
            self.biweeklyLabel.textColor = #colorLiteral(red: 0.7709656358, green: 0.8703430295, blue: 0.5776815414, alpha: 1)
            self.weeklyLabel.textColor = #colorLiteral(red: 0.6849097013, green: 0.8780232072, blue: 0.9137651324, alpha: 1)
            self.isOn = false
            self.biweeklyisOn = true
        }else{
            if(self.biweeklyisOn == true){
                self.biweeklyLabel.textColor = #colorLiteral(red: 0.6849097013, green: 0.8780232072, blue: 0.9137651324, alpha: 1)
                self.weeklyLabel.textColor = #colorLiteral(red: 0.6849097013, green: 0.8780232072, blue: 0.9137651324, alpha: 1)
                self.biweeklyisOn = false
            }else{
                self.biweeklyLabel.textColor = #colorLiteral(red: 0.7709656358, green: 0.8703430295, blue: 0.5776815414, alpha: 1)
                self.weeklyLabel.textColor = #colorLiteral(red: 0.6849097013, green: 0.8780232072, blue: 0.9137651324, alpha: 1)
                self.monthlyLabel.textColor = #colorLiteral(red: 0.6849097013, green: 0.8780232072, blue: 0.9137651324, alpha: 1)    // new logic
                self.justonceLabel.textColor = #colorLiteral(red: 0.6849097013, green: 0.8780232072, blue: 0.9137651324, alpha: 1)    // new logic
                self.isOn = false
                self.monthlyisOn = false    // new logic
                self.justOnceIsOn = false    // new logic
                self.biweeklyisOn = true
            }

        }
        print("weeklybutton is = \(self.isOn)")
        print("Bi-Isweeklybutton is = \(self.biweeklyisOn)")
        print("Monthy-button is = \(self.monthlyisOn)")
        print("JustOnce-button is = \(self.justOnceIsOn)")
    }
    
    @IBAction func monthlyPressed(_ sender: Any) {
        
        if(isOn == true){
            self.monthlyLabel.textColor = #colorLiteral(red: 0.7709656358, green: 0.8703430295, blue: 0.5776815414, alpha: 1)
            self.weeklyLabel.textColor = #colorLiteral(red: 0.6849097013, green: 0.8780232072, blue: 0.9137651324, alpha: 1)
            self.biweeklyLabel.textColor = #colorLiteral(red: 0.6849097013, green: 0.8780232072, blue: 0.9137651324, alpha: 1)  // new logic
            self.justonceLabel.textColor = #colorLiteral(red: 0.6849097013, green: 0.8780232072, blue: 0.9137651324, alpha: 1)  // new logic
            self.isOn = false
            self.biweeklyisOn = false   // new logic
            self.justOnceIsOn = false   // new logic
            self.monthlyisOn = true
        }else{
            if(self.monthlyisOn == true){
                self.monthlyLabel.textColor = #colorLiteral(red: 0.6849097013, green: 0.8780232072, blue: 0.9137651324, alpha: 1)
                self.weeklyLabel.textColor = #colorLiteral(red: 0.6849097013, green: 0.8780232072, blue: 0.9137651324, alpha: 1)
                self.biweeklyLabel.textColor = #colorLiteral(red: 0.6849097013, green: 0.8780232072, blue: 0.9137651324, alpha: 1) // new logic
                self.justonceLabel.textColor = #colorLiteral(red: 0.6849097013, green: 0.8780232072, blue: 0.9137651324, alpha: 1) // new logic
                self.monthlyisOn = false
            }else{
                self.monthlyLabel.textColor = #colorLiteral(red: 0.7709656358, green: 0.8703430295, blue: 0.5776815414, alpha: 1)
                self.weeklyLabel.textColor = #colorLiteral(red: 0.6849097013, green: 0.8780232072, blue: 0.9137651324, alpha: 1)
                self.biweeklyLabel.textColor = #colorLiteral(red: 0.6849097013, green: 0.8780232072, blue: 0.9137651324, alpha: 1) // new logic
                self.justonceLabel.textColor = #colorLiteral(red: 0.6849097013, green: 0.8780232072, blue: 0.9137651324, alpha: 1) // new logic
                self.isOn = false
                self.biweeklyisOn = false // new logic
                self.justOnceIsOn = false // new logic
                self.monthlyisOn = true
            }
            
        }
        
        
        print("weeklybutton is = \(self.isOn)")
        print("Bi-Isweeklybutton is = \(self.biweeklyisOn)")
        print("Monthy-button is = \(self.monthlyisOn)")
        print("JustOnce-button is = \(self.justOnceIsOn)")
    }
    
    @IBAction func JustOncePressed(_ sender: Any) {

        if(isOn == true){
            self.justonceLabel.textColor = #colorLiteral(red: 0.7709656358, green: 0.8703430295, blue: 0.5776815414, alpha: 1)
            self.weeklyLabel.textColor = #colorLiteral(red: 0.6849097013, green: 0.8780232072, blue: 0.9137651324, alpha: 1)
            self.biweeklyLabel.textColor = #colorLiteral(red: 0.6849097013, green: 0.8780232072, blue: 0.9137651324, alpha: 1)  // new logic
            self.monthlyLabel.textColor = #colorLiteral(red: 0.6849097013, green: 0.8780232072, blue: 0.9137651324, alpha: 1)  // new logic
            self.isOn = false
            self.biweeklyisOn = false   // new logic
            self.monthlyisOn = false   // new logic
            self.justOnceIsOn = true
        }else{
            if(self.justOnceIsOn == true){
                self.justonceLabel.textColor = #colorLiteral(red: 0.6849097013, green: 0.8780232072, blue: 0.9137651324, alpha: 1)
                self.weeklyLabel.textColor = #colorLiteral(red: 0.6849097013, green: 0.8780232072, blue: 0.9137651324, alpha: 1)
                self.biweeklyLabel.textColor = #colorLiteral(red: 0.6849097013, green: 0.8780232072, blue: 0.9137651324, alpha: 1) // new logic
                self.monthlyLabel.textColor = #colorLiteral(red: 0.6849097013, green: 0.8780232072, blue: 0.9137651324, alpha: 1) // new logic
                self.justOnceIsOn = false
            }else{
                self.justonceLabel.textColor = #colorLiteral(red: 0.7709656358, green: 0.8703430295, blue: 0.5776815414, alpha: 1)
                self.weeklyLabel.textColor = #colorLiteral(red: 0.6849097013, green: 0.8780232072, blue: 0.9137651324, alpha: 1)
                self.biweeklyLabel.textColor = #colorLiteral(red: 0.6849097013, green: 0.8780232072, blue: 0.9137651324, alpha: 1) // new logic
                self.monthlyLabel.textColor = #colorLiteral(red: 0.6849097013, green: 0.8780232072, blue: 0.9137651324, alpha: 1) // new logic
                self.isOn = false
                self.biweeklyisOn = false // new logic
                self.monthlyisOn = false // new logic
                self.justOnceIsOn = true
            }
            
        }
        
        print("weeklybutton is = \(self.isOn)")
        print("Bi-Isweeklybutton is = \(self.biweeklyisOn)")
        print("Monthy-button is = \(self.monthlyisOn)")
        print("JustOnce-button is = \(self.justOnceIsOn)")
        
    }
    
    @IBAction func ConfirmPressed(_ sender: Any) {
        
        if(self.isOn == true){
            self.howoftendata = "Weekly"
            self.delegate?.sendingData(data: self.howoftendata!)
            HowOften_Extra_Model.singleton.howOften = self.howoftendata
            print(self.howoftendata)
            self.performSegue(withIdentifier: "gotoHomeMain", sender: self)
        }else{
            if(self.biweeklyisOn == true){
                self.howoftendata = "Bi-weekly"
                self.delegate?.sendingData(data: self.howoftendata!)
                HowOften_Extra_Model.singleton.howOften = self.howoftendata
                print(self.howoftendata)
                self.performSegue(withIdentifier: "gotoHomeMain", sender: self)
            }else{
                if(self.monthlyisOn == true){
                    self.howoftendata = "Monthly"
                    self.delegate?.sendingData(data: self.howoftendata!)
                    HowOften_Extra_Model.singleton.howOften = self.howoftendata
                    print(self.howoftendata)
                    self.performSegue(withIdentifier: "gotoHomeMain", sender: self)
                }else{
                    if(self.justOnceIsOn == true){
                        self.howoftendata = "Just Once"
                        self.delegate?.sendingData(data: self.howoftendata!)
                        HowOften_Extra_Model.singleton.howOften = self.howoftendata
                        print(self.howoftendata)
                        self.performSegue(withIdentifier: "gotoHomeMain", sender: self)
                    }else{
                        self.displayMyAlertMessage(userMessage: "Please Select an Option")
                    }
                }
            }
        }
        
    }
    
    // DISPLAY ALERT FUNCTION
    
    func displayMyAlertMessage(userMessage: String) {
        var myalert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        
        myalert.addAction(okAction)
        present(myalert, animated: true, completion: nil)
        
    }
    
}
