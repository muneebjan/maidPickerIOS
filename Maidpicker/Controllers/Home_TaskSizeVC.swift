//
//  Home_TaskSizeVC.swift
//  Maidpicker
//
//  Created by Apple on 01/10/2018.
//  Copyright © 2018 devstop. All rights reserved.
//

import UIKit

var CellValue = ""
let notificationKey1 = "didTappCell"

protocol dropDownProtocol {
    func dropDownPressed(string : String)
}


class Home_TaskSizeVC: UIViewController {

    
    // VIEW OUTLETS
    @IBOutlet weak var bedroomView: Customview!
    @IBOutlet weak var bathroomView: Customview!
    @IBOutlet weak var otherRoomView: Customview!
    @IBOutlet weak var SQFTview: Customview!
    
    // BUTTON and LABEL OUTLETS
    

    @IBOutlet weak var labelBedrooms: UILabel!
    @IBOutlet weak var labelBathrooms: UILabel!
    @IBOutlet weak var labelOtherrooms: UILabel!
    @IBOutlet weak var labelSQFT: UILabel!
    
    
    
    
    var bedroomButton = dropDownBtn()
    var bathroomButton = dropDownBtn()
    var OtherRoomButton = dropDownBtn()

    var isOpen = false
    
    @objc func didTappedCell(_ notification: NSNotification) {
        print(notification.userInfo ?? "")
        if let dict = notification.userInfo as NSDictionary? {
            if let dataCell = dict["data"] as? String{
                self.labelBedrooms.text = dataCell
                self.labelBathrooms.text = dataCell
                self.labelOtherrooms.text = dataCell
            }
        }
    }
    
    // VIEWDID LOAD FUNCTION
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        let named = Notification.Name(rawValue: notificationKey1)
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(self.didTappedCell(_:)), name: named, object: nil)
        
        
        // button checking
        
        //Configure the button
        bedroomButton = dropDownBtn.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        bathroomButton = dropDownBtn.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        OtherRoomButton = dropDownBtn.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        // button addTargets
//        bedroomButton.tag = 1
//        bedroomButton.addTarget(self, action: #selector(self.bedroomButtonTapped(_:)), for: .touchUpInside)
//        bathroomButton.tag = 2
//        bathroomButton.addTarget(self, action: #selector(self.bedroomButtonTapped(_:)), for: .touchUpInside)
//        OtherRoomButton.tag = 3
//        OtherRoomButton.addTarget(self, action: #selector(self.bedroomButtonTapped(_:)), for: .touchUpInside)
        
        bedroomButton.translatesAutoresizingMaskIntoConstraints = false
        bathroomButton.translatesAutoresizingMaskIntoConstraints = false
        OtherRoomButton.translatesAutoresizingMaskIntoConstraints = false
        
        //Add Button to the View Controller
        self.view.addSubview(bedroomButton)
        self.view.addSubview(bathroomButton)
        self.view.addSubview(OtherRoomButton)
        
        //button Constraints
        bedroomButton.centerXAnchor.constraint(equalTo: self.bedroomView.centerXAnchor).isActive = true
        bedroomButton.centerYAnchor.constraint(equalTo: self.bedroomView.centerYAnchor).isActive = true
        bedroomButton.widthAnchor.constraint(equalTo: self.bedroomView.widthAnchor).isActive = true
        bedroomButton.heightAnchor.constraint(equalTo: self.bedroomView.heightAnchor).isActive = true
        
        bathroomButton.centerXAnchor.constraint(equalTo: self.bathroomView.centerXAnchor).isActive = true
        bathroomButton.centerYAnchor.constraint(equalTo: self.bathroomView.centerYAnchor).isActive = true
        bathroomButton.widthAnchor.constraint(equalTo: self.bathroomView.widthAnchor).isActive = true
        bathroomButton.heightAnchor.constraint(equalTo: self.bathroomView.heightAnchor).isActive = true
        
        OtherRoomButton.centerXAnchor.constraint(equalTo: self.otherRoomView.centerXAnchor).isActive = true
        OtherRoomButton.centerYAnchor.constraint(equalTo: self.otherRoomView.centerYAnchor).isActive = true
        OtherRoomButton.widthAnchor.constraint(equalTo: self.otherRoomView.widthAnchor).isActive = true
        OtherRoomButton.heightAnchor.constraint(equalTo: self.otherRoomView.heightAnchor).isActive = true
        
        //Set the drop down menu's options
        bedroomButton.dropView.dropDownOptions = ["1", "2", "4", "5", "6", "8"]
        bathroomButton.dropView.dropDownOptions = ["1", "2", "4", "5", "6", "8"]
        OtherRoomButton.dropView.dropDownOptions = ["1", "2", "4", "5", "6", "8"]
        
        
    }

//    @objc func bedroomButtonTapped(_ sender: UIButton?){
//
//        print("this is sender tag: \(sender?.tag)")
//
////        let name = Notification.Name(rawValue: "buttonPressed")
////        NotificationCenter.default.post(name: name, object: nil)
//
//        let dropView = dropDownView()
//
//        let height = NSLayoutConstraint()
//
////        if isOpen == false {
//
//            isOpen = true
//
//            NSLayoutConstraint.deactivate([height])
//
//            if dropView.tableView.contentSize.height > 150 {
//                height.constant = 150
//            } else {
//                height.constant = dropView.tableView.contentSize.height
//            }
//
//
//            NSLayoutConstraint.activate([height])
//
//            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
//                dropView.layoutIfNeeded()
//                dropView.center.y += dropView.frame.height / 2
//            }, completion: nil)
//
////        } else {
////            isOpen = false
////
////            NSLayoutConstraint.deactivate([height])
////            height.constant = 0
////            NSLayoutConstraint.activate([height])
////            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
////                dropView.center.y -= dropView.frame.height / 2
////                dropView.layoutIfNeeded()
////            }, completion: nil)
////
////        }
//    }
    
}


// ==========================================================================================

                                // DROPDOWNBUTTON CLASS \\

// ==========================================================================================



class dropDownBtn: UIButton ,dropDownProtocol {
    
    
    func dropDownPressed(string: String) {
        
        let stringData:[String: String] = ["data": string]
        
        let name = Notification.Name(rawValue: notificationKey1)
        NotificationCenter.default.post(name: name, object: nil, userInfo: stringData)
        self.dismissDropDown()
    }
    
    var dropView = dropDownView()
    
    var height = NSLayoutConstraint()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clear
        self.layer.borderColor = #colorLiteral(red: 0.1921568662, green: 0.007843137719, blue: 0.09019608051, alpha: 1)
        self.layer.borderWidth = 2
        dropView = dropDownView.init(frame: CGRect.init(x: 100, y: 100, width: 20, height: 20))
        dropView.delegate = self
        dropView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    override func didMoveToSuperview() {
        self.superview?.addSubview(dropView)
        self.superview?.bringSubview(toFront: dropView)
        dropView.topAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        dropView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        dropView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        height = dropView.heightAnchor.constraint(equalToConstant: 0)
    }
    
    var isOpen = false
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let name = Notification.Name(rawValue: "buttonPressed")
        NotificationCenter.default.post(name: name, object: nil)

        if isOpen == false {

            isOpen = true

            NSLayoutConstraint.deactivate([self.height])

            if self.dropView.tableView.contentSize.height > 150 {
                self.height.constant = 150
            } else {
                self.height.constant = self.dropView.tableView.contentSize.height
            }


            NSLayoutConstraint.activate([self.height])

            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                self.dropView.layoutIfNeeded()
                self.dropView.center.y += self.dropView.frame.height / 2
            }, completion: nil)

        } else {
            isOpen = false

            NSLayoutConstraint.deactivate([self.height])
            self.height.constant = 0
            NSLayoutConstraint.activate([self.height])
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                self.dropView.center.y -= self.dropView.frame.height / 2
                self.dropView.layoutIfNeeded()
            }, completion: nil)

        }
    }
    
    func dismissDropDown() {
        isOpen = false
        NSLayoutConstraint.deactivate([self.height])
        self.height.constant = 0
        NSLayoutConstraint.activate([self.height])
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.dropView.center.y -= self.dropView.frame.height / 2
            self.dropView.layoutIfNeeded()
        }, completion: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// ==========================================================================================

                                // DROPDOWNVIEW CLASS \\

// ==========================================================================================



class dropDownView: UIView, UITableViewDelegate, UITableViewDataSource  {
    
    var dropDownOptions = [String]()
    
    var tableView = UITableView()
    
    var delegate : dropDownProtocol!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        tableView.backgroundColor = UIColor.clear
        self.backgroundColor = UIColor.clear
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        //superview?.addSubview(tableView)
        self.addSubview(tableView)
        
        tableView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dropDownOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        cell.textLabel?.text = dropDownOptions[indexPath.row]
        cell.textLabel?.textColor = #colorLiteral(red: 0.7709656358, green: 0.8703430295, blue: 0.5776815414, alpha: 1)
        cell.textLabel?.textAlignment = .center
        cell.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.9568627451, blue: 0.9568627451, alpha: 1) // cell color
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.delegate.dropDownPressed(string: dropDownOptions[indexPath.row])
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
