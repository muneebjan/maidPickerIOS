//
//  Home_When_MainVC.swift
//  Maidpicker
//
//  Created by Apple on 09/10/2018.
//  Copyright © 2018 devstop. All rights reserved.
//

import UIKit

protocol sendingData: class {
    func settingTime(startDate: String, endDate: String)
}

class Home_When_MainVC: UIViewController {
    
    var month: String = ""
    var day: String = ""
    var hours: String = ""
    var mins: String = ""
    
    var delegate: sendingData?
    
    
    @IBOutlet weak var Nowbutton: UIButton!
    @IBOutlet weak var TodayButton: UIButton!
    @IBOutlet weak var FutureButton: UIButton!
    
    
    // view did load
    override func viewDidLoad() {
        super.viewDidLoad()
        if (Extras.singleton.addressID == nil) {
            self.displayMyAlertMessage(userMessage: "Please First Select Location")
            self.Nowbutton.isEnabled = false
            self.TodayButton.isEnabled = false
            self.FutureButton.isEnabled = false
        }else{
            print("address ID: \(Extras.singleton.addressID)")
            self.Nowbutton.isEnabled = true
            self.TodayButton.isEnabled = true
            self.FutureButton.isEnabled = true
        }
        //currentSplitDateandTime()
    }

    
    func currentSplitDateandTime() {
        
        let currentTime =  Extras.singleton.getCurrentTime()
        let splitingtime = currentTime.split(separator: ":")
        month = String(splitingtime[0])
        day = String(splitingtime[1])
        hours = String(splitingtime[2])
        mins = String(splitingtime[3])
        var endHours = Int(hours)!+2
        print(currentTime)
        print("\(month) : \(day) : \(hours) : \(mins)")
        //return (month!, day!, hours!, mins!)
        
        TimeModel.TimeInstance.startTime = "\(hours):\(mins)"
        TimeModel.TimeInstance.endTime = "\(endHours):\(mins)"
        
    }
    
    
// IbAction functions
    @IBAction func NowButtonPressed(_ sender: Any) {
        
        currentSplitDateandTime()
        
       //delegate.settingLabel(startTime: "String")
        print(TimeModel.TimeInstance.startTime!)
        print(TimeModel.TimeInstance.endTime!)
        

        if let startT = TimeModel.TimeInstance.startTime, let endT = TimeModel.TimeInstance.endTime{
            delegate?.settingTime(startDate: startT, endDate: endT)
            // API CALLING
            AuthServices.instance.HomeWhenDataSending(type: "Now", subtype: "Specific", startTime: startT, endTime: endT) { (success) in
                if(success){
                    print("NowButton Calling Api: Successfull")
                    self.performSegue(withIdentifier: "unwindToHome", sender: self)
                }
                else{
                    print("Not successfully")
                }
            }
        }else{
            print("Something is wrong")
        }
    }

    @IBAction func TodayButtonPressed(_ sender: Any) {
        
        let customAlert = self.storyboard?.instantiateViewController(withIdentifier: "CustomPopupSlider") as! CustomPopupSliderView
        customAlert.providesPresentationContextTransitionStyle = true
        customAlert.definesPresentationContext = true
        customAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        customAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        customAlert.delegate = self
        self.present(customAlert, animated: true, completion: nil)
        
    }
    @IBAction func FutureButtonPressed(_ sender: Any) {
        
        let VC = storyboard?.instantiateViewController(withIdentifier: "homeFuture") as! Home_When_Future_VC
        VC.delegate = self
        self.navigationController?.pushViewController(VC, animated: true)
        
    }
}


extension Home_When_MainVC: SliderPopupDelegate{
    
    func confirmButtonTapped(startime: String, endTime: String) {
        print("this is starttime: \(startime)")
        print("this is endtime: \(endTime)")
        TimeModel.TimeInstance.startTime = startime
        TimeModel.TimeInstance.endTime = endTime
        delegate?.settingTime(startDate: startime, endDate: endTime)
        self.performSegue(withIdentifier: "unwindToHome", sender: self)
    }
    
    func cancelButtonTapped() {
        print("cancel button pressed")
    }
    
    // DISPLAY ALERT FUNCTION
    
    func displayMyAlertMessage(userMessage: String) {
        var myalert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        
        myalert.addAction(okAction)
        present(myalert, animated: true, completion: nil)
        
    }
    
    
}
