//
//  Home_TaskSizeVC.swift
//  Maidpicker
//
//  Created by Apple on 01/10/2018.
//  Copyright © 2018 devstop. All rights reserved.
//

import UIKit
import DropDown

// protocol

protocol SelectionDelegate {
    func setTextLabel(text: String)
}

class Home_TaskSizeVC: UIViewController{

    // VIEW OUTLETS
    @IBOutlet weak var bedroomView: Customview!
    @IBOutlet weak var bathroomView: Customview!
    @IBOutlet weak var otherRoomView: Customview!
    @IBOutlet weak var SQFTview: Customview!
    @IBOutlet weak var bedroomDownView: UIView!
    @IBOutlet weak var bathroomDownView: UIView!
    @IBOutlet weak var otherRoomDownView: UIView!
    
    // BUTTON and LABEL OUTLETS
    

    @IBOutlet weak var labelBedrooms: UILabel!
    @IBOutlet weak var labelBathrooms: UILabel!
    @IBOutlet weak var labelOtherrooms: UILabel!
    @IBOutlet weak var labelSQFT: UILabel!
    
    
    // VARIABLES
    
    let dropDown = DropDown()
    
    var item = ""
    var beds: Int = 0
    var bathrooms: Int = 0
    var otherRooms: Int = 0
    var bedroomsData: [String] = []
    var bathroomsData: [String] = []
    var otherRoomsData: [String] = []
    //
    var delegate: SelectionDelegate?
    // VIEWDID LOAD FUNCTION
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.Search_and_Populate()

        
    }
    
    // SEARCHING ADDRESS ID AND POPULATE IN DROP DOWN MENU
    
    func Search_and_Populate() {
        if (Extras.singleton.addressID == nil) {
            self.displayMyAlertMessage(userMessage: "Please Select Location")
        }else{
            for i in 0..<AddressArray.singleton.roomDetailsArray.count{
                if(AddressArray.singleton.addressArray[i].addressID == Extras.singleton.addressID){
                    print("i found it")
                    beds = Int(AddressArray.singleton.roomDetailsArray[i].numberOfRooms!)!
                    bathrooms = Int(AddressArray.singleton.roomDetailsArray[i].numberOfBathrooms!)!
                    otherRooms = Int(AddressArray.singleton.roomDetailsArray[i].otherRooms!)!
                    print("\(beds): \(bathrooms) : \(otherRooms)")
                }
            }
            
            for value in 1..<beds+1 {
                bedroomsData.append(String(value))
            }
            for value in 1..<bathrooms+1 {
                bathroomsData.append(String(value))
            }
            for value in 1..<otherRooms+1 {
                otherRoomsData.append(String(value))
            }
        }
    }
    
    // DATA DISPLAY FUNCTION

    func datadisplay(dataSource: [String], whichbuttonTappe: String) {

        dropDown.dataSource = dataSource
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("buttonName: \(whichbuttonTappe) :Selected item: \(item) at index: \(index)")
            //self.delegate?.setTextLabel(text: item)
            if(whichbuttonTappe == "bedroom"){
                self.labelBedrooms.text = item
            }
            if(whichbuttonTappe == "bathroom"){
                self.labelBathrooms.text = item
            }
            if(whichbuttonTappe == "otherRoom"){
                self.labelOtherrooms.text = item
            }
            self.dropDown.hide()
        }
        dropDown.textFont = UIFont(name: "Montserrat-Regular", size: 17.0)!
        dropDown.textColor = #colorLiteral(red: 0.7709656358, green: 0.8703430295, blue: 0.5776815414, alpha: 1)
        
    }
    
    // IBACTION OUTLETS
    
    @IBAction func bedroomsTapped(_ sender: Any) {
        let bedroomtap = "bedroom"
        datadisplay(dataSource: bedroomsData, whichbuttonTappe: bedroomtap)
        dropDown.anchorView = bedroomDownView
        dropDown.show()
    }
    @IBAction func bathroomTapped(_ sender: Any) {
        let bathroom = "bathroom"
        datadisplay(dataSource: bathroomsData, whichbuttonTappe: bathroom)
        dropDown.anchorView = bathroomDownView
        dropDown.show()
    }
    @IBAction func otherRoomTapped(_ sender: Any) {
        let otherRooms = "otherRoom"
        datadisplay(dataSource: otherRoomsData, whichbuttonTappe: otherRooms)
        dropDown.anchorView = otherRoomDownView
        dropDown.show()
    }
    
    // DISPLAY ALERT FUNCTION
    
    func displayMyAlertMessage(userMessage: String) {
        var myalert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        
        myalert.addAction(okAction)
        present(myalert, animated: true, completion: nil)
        
    }
    
}
