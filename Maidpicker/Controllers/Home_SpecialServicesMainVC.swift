//
//  Home_SpecialServicesVC.swift
//  Maidpicker
//
//  Created by Apple on 17/10/2018.
//  Copyright © 2018 devstop. All rights reserved.
//

import UIKit
import DropDown

class Home_SpecialServicesMainVC: UIViewController {
    
    // OUTLETS
    @IBOutlet weak var roomLabel: UILabel!
    @IBOutlet weak var RoomsView: UIView!
    @IBOutlet weak var sqftTextField: UITextField!
    
    // VARIABLES
    var beds: Int = 0
    var otherRooms: Int = 0
    
    var bedroomsData: [String] = []
    var otherRoomsData: [String] = []
    var totalRooms: [String] = []
    var SelectedRooms: String?
    
    let dropDown = DropDown()
    
    // viewdidload
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
                    otherRooms = Int(AddressArray.singleton.roomDetailsArray[i].otherRooms!)!
                    print("\(beds) : \(otherRooms)")
                }
            }
            
            for value in 1..<beds+1 {
                bedroomsData.append(String(value))
            }
            for value in 1..<otherRooms+1 {
                otherRoomsData.append(String(value))
            }
            for value in 1..<beds+otherRooms+1 {
                totalRooms.append(String(value))
            }
        }
    }
    
    // DATA DISPLAY FUNCTION
    func datadisplay(dataSource: [String]) {
        
        dropDown.dataSource = dataSource
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            //self.delegate?.setTextLabel(text: item)
//            if(whichbuttonTappe == "bedroom"){
//                self.labelBedrooms.text = item
//                self.Selectedbedrooms = item
//            }
//            if(whichbuttonTappe == "otherRoom"){
//                self.labelOtherrooms.text = item
//                self.SelectedotherRooms = item
//            }
            
            self.roomLabel.text = item
            self.SelectedRooms = item
            SpecialServiceModel.singleton.allrooms = Int(item)
            self.dropDown.hide()
        }
        dropDown.textFont = UIFont(name: "Montserrat-Regular", size: 17.0)!
        dropDown.textColor = #colorLiteral(red: 0.7709656358, green: 0.8703430295, blue: 0.5776815414, alpha: 1)
        
    }
    
    
    @IBAction func RoomsTapped(_ sender: Any) {
        print("button pressed")
        self.datadisplay(dataSource: totalRooms)
        dropDown.anchorView = RoomsView
        dropDown.show()
    }
    
    @IBAction func NextTapped(_ sender: Any) {
        if let textField = self.sqftTextField.text{
            print(textField)
            SpecialServiceModel.singleton.squarefeets = Int(textField)
        }
        if(SelectedRooms != nil && self.sqftTextField.text != "0" && self.sqftTextField.text != ""){
            print("rooms and sqft are selected")
            let VC = storyboard?.instantiateViewController(withIdentifier: "SpecialServicePhoto") as! Home_Special_ServicesPhotosVC
            self.navigationController?.pushViewController(VC, animated: true)
        }else{
            print("missing something")
        }
    }
    
    
    // DISPLAY ALERT FUNCTION
    
    func displayMyAlertMessage(userMessage: String) {
        var myalert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        
        myalert.addAction(okAction)
        present(myalert, animated: true, completion: nil)
        
    }
    
    //  METHOD TO DISABLE KEYBOARD
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
