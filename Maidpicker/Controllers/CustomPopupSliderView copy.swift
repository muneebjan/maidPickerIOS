//
//  CustomAlertView.swift
//  CustomAlertView
//
//  Created by Daniel Luque Quintana on 16/3/17.
//  Copyright © 2017 dluque. All rights reserved.
//

import UIKit

protocol SliderPopupDelegate: class {
    func confirmButtonTapped(startime: String, endTime: String)
    func cancelButtonTapped()
}


class CustomPopupSliderView: UIViewController {
    
    @IBOutlet weak var startTime: UILabel!
    @IBOutlet weak var endTime: UILabel!
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var okButton: UIButton!
    
    
    var startSlider: Int = 0
    var endSlider: Int = 0
    
    
    @IBAction func startSlider(_ sender: UISlider) {
        startSlider = Int(sender.value)
        startTime.text = "\(Int(sender.value)):00"
    }
    @IBAction func slider(_ sender: UISlider) {
        endSlider = Int(sender.value)
        endTime.text = "\(Int(sender.value)):00"
    }
    
    var delegate: SliderPopupDelegate?
    let alertViewGrayColor = UIColor(red: 224.0/255.0, green: 224.0/255.0, blue: 224.0/255.0, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
        animateView()
        cancelButton.addBorder(side: .Top, color: alertViewGrayColor, width: 1)
        cancelButton.addBorder(side: .Right, color: alertViewGrayColor, width: 1)
        cancelButton.backgroundColor = #colorLiteral(red: 0.7709656358, green: 0.8703430295, blue: 0.5776815414, alpha: 1)
        okButton.addBorder(side: .Top, color: alertViewGrayColor, width: 1)
        okButton.backgroundColor = #colorLiteral(red: 0.6849097013, green: 0.8780232072, blue: 0.9137651324, alpha: 1)
    }
    
    func setupView() {
        alertView.layer.cornerRadius = 5
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
    }
    
    func animateView() {
        alertView.alpha = 0;
        self.alertView.frame.origin.y = self.alertView.frame.origin.y + 50
        UIView.animate(withDuration: 0.4, animations: { () -> Void in
            self.alertView.alpha = 1.0;
            self.alertView.frame.origin.y = self.alertView.frame.origin.y - 50
        })
    }
    
    @IBAction func onTapCancelButton(_ sender: Any) {
        delegate?.cancelButtonTapped()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onTapOkButton(_ sender: Any) {
//        delegate?.okButtonTapped(roomTextField: room, bathroomTextField: bathrooms, AreaTextfield: area)
        if (startSlider >= endSlider) {
            self.displayMyAlertMessage(userMessage: "Start Time must be Smaller than End Time")
        }else{
            print("time is correct")
            delegate?.confirmButtonTapped(startime: "\(startSlider):00", endTime: "\(endSlider):00")
            
            // API CALLING
            AuthServices.instance.HomeWhenDataSending(type: "Today", subtype: "Specific", startTime: "\(startSlider):00", endTime: "\(endSlider):00") { (success) in
                if(success){
                    print("Today Calling Api: Successfull")
                }
                else{
                    print("Not successfully")
                }
            }
            
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    
    func displayMyAlertMessage(userMessage: String) {
        var myalert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        myalert.addAction(okAction)
        present(myalert, animated: true, completion: nil)
        
    }
}
