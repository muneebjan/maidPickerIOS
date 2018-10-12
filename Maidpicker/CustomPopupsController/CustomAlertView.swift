//
//  CustomAlertView.swift
//  CustomAlertView
//
//  Created by Daniel Luque Quintana on 16/3/17.
//  Copyright © 2017 dluque. All rights reserved.
//

import UIKit

class CustomAlertView: UIViewController {
    
    @IBOutlet weak var roomsTextField: UITextField!
    @IBOutlet weak var bathroomsTextField: UITextField!
    @IBOutlet weak var otherRoomsTextField: UITextField!
    @IBOutlet weak var AreaTextField: UITextField!
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var okButton: UIButton!
    
    var delegate: CustomAlertViewDelegate?
    let alertViewGrayColor = UIColor(red: 224.0/255.0, green: 224.0/255.0, blue: 224.0/255.0, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        roomsTextField.becomeFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
        animateView()
        cancelButton.addBorder(side: .Top, color: alertViewGrayColor, width: 1)
        cancelButton.addBorder(side: .Right, color: alertViewGrayColor, width: 1)
        okButton.addBorder(side: .Top, color: alertViewGrayColor, width: 1)
    }
    
    func setupView() {
        alertView.layer.cornerRadius = 15
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
        roomsTextField.resignFirstResponder()
        delegate?.cancelButtonTapped()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onTapOkButton(_ sender: Any) {
        guard let room = roomsTextField.text,
              let bathrooms = bathroomsTextField.text,
              let otherRooms = otherRoomsTextField.text,
              let area = AreaTextField.text
        else {return}
        roomsTextField.resignFirstResponder()
        delegate?.okButtonTapped(roomTextField: room, bathroomTextField: bathrooms, otherRoomTextField: otherRooms, AreaTextfield: area)
        self.dismiss(animated: true, completion: nil)
    }
    
}
