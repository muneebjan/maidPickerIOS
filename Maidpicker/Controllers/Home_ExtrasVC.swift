//
//  Home_ExtrasVC.swift
//  Maidpicker
//
//  Created by Apple on 16/10/2018.
//  Copyright © 2018 devstop. All rights reserved.
//

import UIKit

protocol ExtasClassProtocol {
    func sendingDataExtra(data: [String])
}


class Home_ExtrasVC: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    // UI OUTLETS
    @IBOutlet weak var DeepCleanLabel: UILabel!
    @IBOutlet weak var InsideCabinetsLabel: UILabel!
    @IBOutlet weak var InsideFridgeLabel: UILabel!
    @IBOutlet weak var InsideOvenLabel: UILabel!
    @IBOutlet weak var LaundryLabel: UILabel!
    @IBOutlet weak var InteriorWindowsLabel: UILabel!
    
    @IBOutlet weak var DeepCleanButton: UIButton!
    @IBOutlet weak var InsideCabinetsButton: UIButton!
    @IBOutlet weak var InsideFridgeButton: UIButton!
    @IBOutlet weak var InsideOvenButton: UIButton!
    @IBOutlet weak var LaundryButton: UIButton!
    @IBOutlet weak var InteriorWindowsButton: UIButton!
    
    var Fulltime: Int = 0
    
    var deepCleanIsOn: Bool = false
    var insideCabIsOn: Bool = false
    var insideFridgeisOn: Bool = false
    var insideOvenIsOn: Bool = false
    var laundryIsOn: Bool = false
    var interiorWindowIsOn: Bool = false
    
    var boolDict : [String:Bool] = [:]
    
    var delegate: ExtasClassProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    // converting INT to Hours and Minutes
    func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int) {
        return ((seconds % 3600) / 60, (seconds % 3600) % 60)
    }

    
    func appendingValues() {
        boolDict.updateValue(self.deepCleanIsOn, forKey: "Deep Clean")
        boolDict.updateValue(self.insideCabIsOn, forKey: "Inside Cabinets")
        boolDict.updateValue(self.insideFridgeisOn, forKey: "Inside Fridge")
        boolDict.updateValue(self.insideOvenIsOn, forKey: "Inside Oven")
        boolDict.updateValue(self.laundryIsOn, forKey: "Laundry")
        boolDict.updateValue(self.interiorWindowIsOn, forKey: "Interior Windows")
    }
    
    @IBAction func DeepCleanPressed(_ sender: UIButton) {
        
        //
        // CALLING API
        
        self.boolDict.removeAll()
        
        if(deepCleanIsOn == true){
            print("deepclean is on ")
            if(insideCabIsOn == true){
                self.DeepCleanLabel.textColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
                self.deepCleanIsOn = false
            }else{
                
                self.DeepCleanLabel.textColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
                self.deepCleanIsOn = false

                ExtraModel.singleton.eta = ExtraModel.singleton.eta!-self.Fulltime
                print("remaingtime: \(ExtraModel.singleton.eta!)")
                if let eta = ExtraModel.singleton.eta{
                    let (h, m) = self.secondsToHoursMinutesSeconds(seconds: eta)
                    self.Fulltime = eta
                    print ("\(h) Hours, \(m) Minutes")
                    self.timeLabel.text = "\(h) Hours, \(m) Minutes"
                }
                
            }
        }else{
            self.DeepCleanLabel.textColor = #colorLiteral(red: 0.7709656358, green: 0.8703430295, blue: 0.5776815414, alpha: 1)
            self.deepCleanIsOn = true
            
            AuthServices.instance.gettingExtraData(id: 1) { (success) in
                if(success){
                    print("api successfull")
                    if let eta = ExtraModel.singleton.eta{
                        let (h, m) = self.secondsToHoursMinutesSeconds(seconds: eta)
                        self.Fulltime = eta
                        print ("\(h) Hours, \(m) Minutes")
                        self.timeLabel.text = "\(h) Hours, \(m) Minutes"
                    }
                }else{
                    print("not successfull")
                }
            }
            
        }
        
        print("DeepCleanButton is = \(self.deepCleanIsOn)")
        print("InsideCabinetButton is = \(self.insideCabIsOn)")
        print("InsideFridgeButton is = \(self.insideFridgeisOn)")
        print("InsideOvenButton is = \(self.insideOvenIsOn)")
        print("LaundryButton is = \(self.laundryIsOn)")
        print("InteriorWindowButton is = \(self.interiorWindowIsOn)")
        
        self.appendingValues()
        dump(boolDict)
    }
    
    @IBAction func InsideCabinetsPressed(_ sender: UIButton) {
        
        self.boolDict.removeAll()
        
        if(deepCleanIsOn == true){
            print("deepclean is on ")
            if(insideCabIsOn == true){
                self.InsideCabinetsLabel.textColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
                self.insideCabIsOn = false
                
                
                ExtraModel.singleton.eta = ExtraModel.singleton.eta!-self.Fulltime
                print("remaingtime: \(ExtraModel.singleton.eta!)")
                if let eta = ExtraModel.singleton.eta{
                    let (h, m) = self.secondsToHoursMinutesSeconds(seconds: eta)
                    self.Fulltime = eta
                    print ("\(h) Hours, \(m) Minutes")
                    self.timeLabel.text = "\(h) Hours, \(m) Minutes"
                }
                
                
            }else{
                self.InsideCabinetsLabel.textColor = #colorLiteral(red: 0.7709656358, green: 0.8703430295, blue: 0.5776815414, alpha: 1)
                self.insideCabIsOn = true
                //
                AuthServices.instance.gettingExtraData(id: 2) { (success) in
                    if(success){
                        print("api successfull")
                        if let eta = ExtraModel.singleton.eta{
                            let (h, m) = self.secondsToHoursMinutesSeconds(seconds: eta+self.Fulltime)
                            //                            self.Fulltime = eta
                            print ("\(h) Hours, \(m) Minutes")
                            self.timeLabel.text = "\(h) Hours, \(m) Minutes"
                        }
                    }else{
                        print("not successfull")
                    }
                }
            }
        }else{
            print("deepclean is off")
            if(insideCabIsOn == true){
                self.InsideCabinetsLabel.textColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
                self.insideCabIsOn = false
            }else{
                self.InsideCabinetsLabel.textColor = #colorLiteral(red: 0.7709656358, green: 0.8703430295, blue: 0.5776815414, alpha: 1)
                self.insideCabIsOn = true
                
                //
                AuthServices.instance.gettingExtraData(id: 2) { (success) in
                    if(success){
                        print("api successfull")
                        if let eta = ExtraModel.singleton.eta{
                            let (h, m) = self.secondsToHoursMinutesSeconds(seconds: eta+self.Fulltime)
//                            self.Fulltime = eta
                            print ("\(h) Hours, \(m) Minutes")
                            self.timeLabel.text = "\(h) Hours, \(m) Minutes"
                        }
                    }else{
                        print("not successfull")
                    }
                }
                
                
            }

        }
        print("DeepCleanButton is = \(self.deepCleanIsOn)")
        print("InsideCabinetButton is = \(self.insideCabIsOn)")
        print("InsideFridgeButton is = \(self.insideFridgeisOn)")
        print("InsideOvenButton is = \(self.insideOvenIsOn)")
        print("LaundryButton is = \(self.laundryIsOn)")
        print("InteriorWindowButton is = \(self.interiorWindowIsOn)")
        
        self.appendingValues()
        dump(boolDict)
    }
    
    @IBAction func InsideFridgePressed(_ sender: Any) {
        
        self.boolDict.removeAll()
        
        if(insideCabIsOn == true){
            print("deepclean is on ")
            if(insideFridgeisOn == true){
                self.InsideFridgeLabel.textColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
                self.insideFridgeisOn = false
            }else{
                self.InsideFridgeLabel.textColor = #colorLiteral(red: 0.7709656358, green: 0.8703430295, blue: 0.5776815414, alpha: 1)
                self.insideFridgeisOn = true
            }
        }else{
            print("deepclean is off")
            if(insideFridgeisOn == true){
                self.InsideFridgeLabel.textColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
                self.insideFridgeisOn = false
            }else{
                self.InsideFridgeLabel.textColor = #colorLiteral(red: 0.7709656358, green: 0.8703430295, blue: 0.5776815414, alpha: 1)
                self.insideFridgeisOn = true
            }
            
        }
        print("DeepCleanButton is = \(self.deepCleanIsOn)")
        print("InsideCabinetButton is = \(self.insideCabIsOn)")
        print("InsideFridgeButton is = \(self.insideFridgeisOn)")
        print("InsideOvenButton is = \(self.insideOvenIsOn)")
        print("LaundryButton is = \(self.laundryIsOn)")
        print("InteriorWindowButton is = \(self.interiorWindowIsOn)")
        
        self.appendingValues()
        dump(boolDict)
    }
    
    @IBAction func InsideOvenPressed(_ sender: Any) {
        
        self.boolDict.removeAll()
        
        if(insideFridgeisOn == true){
            print("deepclean is on ")
            if(insideOvenIsOn == true){
                self.InsideOvenLabel.textColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
                self.insideOvenIsOn = false
            }else{
                self.InsideOvenLabel.textColor = #colorLiteral(red: 0.7709656358, green: 0.8703430295, blue: 0.5776815414, alpha: 1)
                self.insideOvenIsOn = true
            }
        }else{
            print("deepclean is off")
            if(insideOvenIsOn == true){
                self.InsideOvenLabel.textColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
                self.insideOvenIsOn = false
            }else{
                self.InsideOvenLabel.textColor = #colorLiteral(red: 0.7709656358, green: 0.8703430295, blue: 0.5776815414, alpha: 1)
                self.insideOvenIsOn = true
            }
            
        }
        print("DeepCleanButton is = \(self.deepCleanIsOn)")
        print("InsideCabinetButton is = \(self.insideCabIsOn)")
        print("InsideFridgeButton is = \(self.insideFridgeisOn)")
        print("InsideOvenButton is = \(self.insideOvenIsOn)")
        print("LaundryButton is = \(self.laundryIsOn)")
        print("InteriorWindowButton is = \(self.interiorWindowIsOn)")
        
        self.appendingValues()
        dump(boolDict)
    }
    
    @IBAction func LaundryPressed(_ sender: Any) {
        
        self.boolDict.removeAll()
        
        if(insideOvenIsOn == true){
            if(laundryIsOn == true){
                self.LaundryLabel.textColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
                self.laundryIsOn = false
            }else{
                self.LaundryLabel.textColor = #colorLiteral(red: 0.7709656358, green: 0.8703430295, blue: 0.5776815414, alpha: 1)
                self.laundryIsOn = true
            }
        }else{
            if(laundryIsOn == true){
                self.LaundryLabel.textColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
                self.laundryIsOn = false
            }else{
                self.LaundryLabel.textColor = #colorLiteral(red: 0.7709656358, green: 0.8703430295, blue: 0.5776815414, alpha: 1)
                self.laundryIsOn = true
            }
            
        }
        print("DeepCleanButton is = \(self.deepCleanIsOn)")
        print("InsideCabinetButton is = \(self.insideCabIsOn)")
        print("InsideFridgeButton is = \(self.insideFridgeisOn)")
        print("InsideOvenButton is = \(self.insideOvenIsOn)")
        print("LaundryButton is = \(self.laundryIsOn)")
        print("InteriorWindowButton is = \(self.interiorWindowIsOn)")
        
        self.appendingValues()
        dump(boolDict)
    }
    
    
    @IBAction func InteriorWindowPressed(_ sender: Any) {
        
        self.boolDict.removeAll()
        
        if(laundryIsOn == true){
            if(interiorWindowIsOn == true){
                self.InteriorWindowsLabel.textColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
                self.interiorWindowIsOn = false
            }else{
                self.InteriorWindowsLabel.textColor = #colorLiteral(red: 0.7709656358, green: 0.8703430295, blue: 0.5776815414, alpha: 1)
                self.interiorWindowIsOn = true
            }
        }else{
            if(interiorWindowIsOn == true){
                self.InteriorWindowsLabel.textColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
                self.interiorWindowIsOn = false
            }else{
                self.InteriorWindowsLabel.textColor = #colorLiteral(red: 0.7709656358, green: 0.8703430295, blue: 0.5776815414, alpha: 1)
                self.interiorWindowIsOn = true
            }
            
        }
        print("DeepCleanButton is = \(self.deepCleanIsOn)")
        print("InsideCabinetButton is = \(self.insideCabIsOn)")
        print("InsideFridgeButton is = \(self.insideFridgeisOn)")
        print("InsideOvenButton is = \(self.insideOvenIsOn)")
        print("LaundryButton is = \(self.laundryIsOn)")
        print("InteriorWindowButton is = \(self.interiorWindowIsOn)")
        
        self.appendingValues()
        
        dump(boolDict)
        
    }
    
    

    @IBAction func ConfirmBtnPressed(_ sender: Any) {

        let key = boolDict.keysForValue(value: true)
        print("this is key: \(key)")
        HowOften_Extra_Model.singleton.Extra = key
        self.delegate?.sendingDataExtra(data: key)
        self.performSegue(withIdentifier: "gotoHomeMain", sender: self)
    }
    
    func displayMyAlertMessage(userMessage: String) {
        var myalert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        
        myalert.addAction(okAction)
        present(myalert, animated: true, completion: nil)
        
    }
    
}

extension Dictionary where Value: Equatable {

    func keysForValue(value: Value) -> [Key] {
        return flatMap { (key: Key, val: Value) -> Key? in
            value == val ? key : nil
        }
    }
}
