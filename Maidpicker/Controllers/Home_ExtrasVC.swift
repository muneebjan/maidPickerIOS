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
    
    var deepCleanTime: Int = 0
    var insideCabTime: Int = 0
    var insideFridgeTime: Int = 0
    var insideOvenTime: Int = 0
    var laundryTime: Int = 0
    var interiorWindowTime: Int = 0
    
    var deepCleanPrice: Int = 0
    var insideCabPrice: Int = 0
    var insideFridgePrice: Int = 0
    var insideOvenPrice: Int = 0
    var laundryPrice: Int = 0
    var interiorWindowPrice: Int = 0
    
    
    
    
    
    var Fulltime: Int = 0
    var FullPrice: Int = 0
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

    
// ================================================================================================
// ===========================Subtracting and Adding API Function =================================
// ================================================================================================
    
    
    func subtimeandprice(id: Int) {
    
        print("here: \(self.Fulltime):\(self.FullPrice)")
        
        AuthServices.instance.gettingExtraData(id: id) { (success) in
            if(success){
                print("api successfull")
                if let time = ExtraModel.singleton.eta, let price = ExtraModel.singleton.money{
                    print(time)
                    print(price)
                    self.Fulltime = self.Fulltime-time
                    self.FullPrice = self.FullPrice-price
                    let (h, m) = self.secondsToHoursMinutesSeconds(seconds: self.Fulltime)
                    print ("\(h) Hours, \(m) Minutes")
                    self.timeLabel.text = "\(h) Hours, \(m) Minutes"
                    self.priceLabel.text = "Total: $\(self.FullPrice)"
                    
                    print("remaining time: \(self.Fulltime)")
                    print("remaining price: \(self.FullPrice)")
                    
                }
            }else{
                print("not successfull")
            }
        }
    
    }
    
    func Addtimeandprice(id: Int) {
        
        print("here: \(self.Fulltime):\(self.FullPrice)")
        
        AuthServices.instance.gettingExtraData(id: id) { (success) in
            if(success){
                print("api successfull")
                if let time = ExtraModel.singleton.eta, let price = ExtraModel.singleton.money{
                    
                    if(id == 1){
                        self.deepCleanTime = time
                        self.deepCleanPrice = price
                    }
                    if(id == 2){
                        self.insideCabTime = time
                        self.insideCabPrice = price
                    }
                    if(id == 3){
                        self.insideFridgeTime = time
                        self.insideFridgePrice = price
                    }
                    if(id == 4){
                        self.insideOvenTime = time
                        self.insideOvenPrice = price
                    }
                    if(id == 5){
                        self.laundryTime = time
                        self.laundryPrice = price
                    }
                    if(id == 6){
                        self.interiorWindowTime = time
                        self.interiorWindowPrice = price
                    }
                    
                    
                    self.Fulltime = self.Fulltime+time
                    self.FullPrice = self.FullPrice+price
                    let (h, m) = self.secondsToHoursMinutesSeconds(seconds: self.Fulltime)
                    print ("\(h) Hours, \(m) Minutes")
                    self.timeLabel.text = "\(h) Hours, \(m) Minutes"
                    self.priceLabel.text = "Total: $\(self.FullPrice)"
                    
                    print("remaining time: \(self.Fulltime)")
                    print("remaining price: \(self.FullPrice)")
                    
                }
            }else{
                print("not successfull")
            }
        }
        
    }
    
    
// ================================================================================================
// =========================================== END ================================================
// ================================================================================================
    
    
    @IBAction func DeepCleanPressed(_ sender: UIButton) {
        
        //
        // CALLING API
        
        self.boolDict.removeAll()
        
        if(deepCleanIsOn == true){
            print("deepclean is on ")
            if(insideCabIsOn == true){
                self.DeepCleanLabel.textColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
                self.deepCleanIsOn = false

                self.subtimeandprice(id: 1) // subtracting api
                
            }
            else{
                
                self.DeepCleanLabel.textColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
                self.deepCleanIsOn = false
                
                self.subtimeandprice(id: 1) // subtracting api
                
            }
        }else{
            self.DeepCleanLabel.textColor = #colorLiteral(red: 0.7709656358, green: 0.8703430295, blue: 0.5776815414, alpha: 1)
            self.deepCleanIsOn = true
            
            self.Addtimeandprice(id: 1) // adding api
            
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
                
                print("remaining time: \(self.Fulltime)")
                print("remaining price: \(self.FullPrice)")
                
                self.subtimeandprice(id: 2) // subtracting api

                
            }else{
                self.InsideCabinetsLabel.textColor = #colorLiteral(red: 0.7709656358, green: 0.8703430295, blue: 0.5776815414, alpha: 1)
                self.insideCabIsOn = true
                
                
                self.Addtimeandprice(id: 2) // adding apis
                
            }
        }else{
            print("deepclean is off")
            if(insideCabIsOn == true){
                self.InsideCabinetsLabel.textColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
                self.insideCabIsOn = false
                
                self.subtimeandprice(id: 2) // subtracting api

                
            }else{
                self.InsideCabinetsLabel.textColor = #colorLiteral(red: 0.7709656358, green: 0.8703430295, blue: 0.5776815414, alpha: 1)
                self.insideCabIsOn = true
                
                
                self.Addtimeandprice(id: 2) // adding apis
                
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
                
                self.subtimeandprice(id: 3) // subtracting api
                
            }else{
                self.InsideFridgeLabel.textColor = #colorLiteral(red: 0.7709656358, green: 0.8703430295, blue: 0.5776815414, alpha: 1)
                self.insideFridgeisOn = true
                
                self.Addtimeandprice(id: 3) // adding apis
                
            }
        }else{
            print("deepclean is off")
            if(insideFridgeisOn == true){
                self.InsideFridgeLabel.textColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
                self.insideFridgeisOn = false
                
                self.subtimeandprice(id: 3) // subtracting api
                
            }else{
                self.InsideFridgeLabel.textColor = #colorLiteral(red: 0.7709656358, green: 0.8703430295, blue: 0.5776815414, alpha: 1)
                self.insideFridgeisOn = true
                
                self.Addtimeandprice(id: 3) // adding apis
                
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
                
                self.subtimeandprice(id: 4) // subtracting api
                
            }else{
                self.InsideOvenLabel.textColor = #colorLiteral(red: 0.7709656358, green: 0.8703430295, blue: 0.5776815414, alpha: 1)
                self.insideOvenIsOn = true
                
                self.Addtimeandprice(id: 4) // adding apis
                
            }
        }else{
            print("deepclean is off")
            if(insideOvenIsOn == true){
                self.InsideOvenLabel.textColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
                self.insideOvenIsOn = false
                
                self.subtimeandprice(id: 4) // subtracting api
                
            }else{
                self.InsideOvenLabel.textColor = #colorLiteral(red: 0.7709656358, green: 0.8703430295, blue: 0.5776815414, alpha: 1)
                self.insideOvenIsOn = true
                
                self.Addtimeandprice(id: 4) // adding apis
                
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
                
                self.subtimeandprice(id: 5) // subtracting api
                
            }else{
                self.LaundryLabel.textColor = #colorLiteral(red: 0.7709656358, green: 0.8703430295, blue: 0.5776815414, alpha: 1)
                self.laundryIsOn = true
                
                self.Addtimeandprice(id: 5) // adding apis
                
            }
        }else{
            if(laundryIsOn == true){
                self.LaundryLabel.textColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
                self.laundryIsOn = false
                
                self.subtimeandprice(id: 5) // subtracting api
                
            }else{
                self.LaundryLabel.textColor = #colorLiteral(red: 0.7709656358, green: 0.8703430295, blue: 0.5776815414, alpha: 1)
                self.laundryIsOn = true
                
                self.Addtimeandprice(id: 5) // adding apis
                
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
                
                self.subtimeandprice(id: 6) // subtracting api
                
            }else{
                self.InteriorWindowsLabel.textColor = #colorLiteral(red: 0.7709656358, green: 0.8703430295, blue: 0.5776815414, alpha: 1)
                self.interiorWindowIsOn = true
                
                self.Addtimeandprice(id: 6) // adding apis
                
            }
        }else{
            if(interiorWindowIsOn == true){
                self.InteriorWindowsLabel.textColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
                self.interiorWindowIsOn = false
                
                self.subtimeandprice(id: 6) // subtracting api
                
            }else{
                self.InteriorWindowsLabel.textColor = #colorLiteral(red: 0.7709656358, green: 0.8703430295, blue: 0.5776815414, alpha: 1)
                self.interiorWindowIsOn = true
                
                self.Addtimeandprice(id: 6) // adding apis
                
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
        

//        print("\(self.deepCleanTime),\(self.deepCleanPrice)")
//        print("\(self.insideCabTime),\(self.insideCabPrice)")
//        print("\(self.insideOvenTime),\(self.insideOvenPrice)")
//        print("\(self.insideFridgeTime),\(self.insideFridgePrice)")
//        print("\(self.laundryTime)","\(self.laundryPrice)")
        
        var populateArray = [String:[String]]()
        
        let key = boolDict.keysForValue(value: true)
        print("this is key: \(key)")
        HowOften_Extra_Model.singleton.Extra = key
        
        for (key, value) in boolDict {
            if(value == true){
                if(key == "Deep Clean"){
                    populateArray[key] = ["\(self.deepCleanTime)","\(self.deepCleanPrice)"]
                    ExtraModel.singleton.deepcleanId = 1
                }
                if(key == "Inside Cabinets"){
                    populateArray[key] = ["\(self.insideCabTime)","\(self.insideCabPrice)"]
                    ExtraModel.singleton.insideCabinetId = 1
                }
                if(key == "Inside Oven"){
                    populateArray[key] = ["\(self.insideOvenTime)","\(self.insideOvenPrice)"]
                    ExtraModel.singleton.insideOvenId = 1
                }
                if(key == "Inside Fridge"){
                    populateArray[key] = ["\(self.insideFridgeTime)","\(self.insideFridgePrice)"]
                    ExtraModel.singleton.insideFridgeId = 1
                }
                if(key == "Laundry"){
                    populateArray[key] = ["\(self.laundryTime)","\(self.laundryPrice)"]
                    ExtraModel.singleton.LaundryId = 1
                }
                if(key == "Interior Windows"){
                    populateArray[key] = ["\(self.interiorWindowTime)","\(self.interiorWindowPrice)"]
                    ExtraModel.singleton.interiorWindowId = 1
                }
            }
        }
        
        
//        for data in key{
//            populateArray[data] = ["\(self.deepCleanTime)","\(self.deepCleanPrice)"]
//        }
        print(populateArray)
        HowOften_Extra_Model.singleton.completeExtraDataArray = populateArray
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
