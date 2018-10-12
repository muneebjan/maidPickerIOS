//
//  AddressOfServiceVC.swift
//  Maidpicker
//
//  Created by Apple on 19/09/2018.
//  Copyright © 2018 devstop. All rights reserved.
//

import UIKit

class AddressOfServiceVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    

    @IBOutlet weak var AddressTableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        
        AddressArray.singleton.addressArray.removeAll()
        AddressArray.singleton.roomDetailsArray.removeAll()
        
        AuthServices.instance.getAddressbyID(userid: User.userInstance.Userid!) { (success) in
            if(success){
                print("address Array count: \(AddressArray.singleton.addressArray.count)")
                print("room detail Array count: \(AddressArray.singleton.roomDetailsArray.count)")
                self.AddressTableView.reloadData()
            }
        }
        

        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        AddressTableView.delegate = self
        AddressTableView.dataSource = self
    
        
    }
    
    // Table view functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AddressArray.singleton.addressArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "addressIdentifier") as? LocationAddTVC{
            
            cell.AddressLabel.text = AddressArray.singleton.addressArray[indexPath.row].AddressName
            cell.detailedAddressLabel.text = AddressArray.singleton.addressArray[indexPath.row].AddressDetail
            cell.rooms.image = UIImage(named: "room.png")
            cell.bathrooms.image = UIImage(named: "bath.png")
            cell.otherRooms.image = UIImage(named: "room.png")
            cell.area.image = UIImage(named: "area.png")
        
            cell.no_Rooms.text = AddressArray.singleton.roomDetailsArray[indexPath.row].numberOfRooms
            cell.no_Bathrooms.text = AddressArray.singleton.roomDetailsArray[indexPath.row].numberOfBathrooms
            cell.otherRoomslabel.text = AddressArray.singleton.roomDetailsArray[indexPath.row].otherRooms
            cell.Area_Room.text = AddressArray.singleton.roomDetailsArray[indexPath.row].AreaOfRoom
            
            return cell
            
        }
        else{
            return LocationAddTVC()
        }
        
    }
    
//    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        return true
//    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {

        if tableView.isEditing {
            print("returning delete")
            return .none
        }
        print("returning none")
        return .none
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let Deletebutton = UITableViewRowAction(style: .normal, title: "Delete") { (rowAction, indexpath) in
            print("Delete Button Clicked")

            //delete API CALLING:
//            AuthServices.instance.Delete_Address(uid: User.userInstance.Userid!, id: <#T##String#>, completion: { (<#Bool#>) in
//                <#code#>
//            })
            
            self.AddressTableView.reloadData()
            print("Record Deleted")
        }
        Deletebutton.backgroundColor = UIColor.red
        
        let editbutton = UITableViewRowAction(style: .normal, title: "Edit") { (rowAction, indexpath) in
            print("Edit Clicked")
        }
        editbutton.backgroundColor = UIColor.green
        
        return [Deletebutton,editbutton]
    }

    // IBAction Functions
    
    
    @IBAction func addLocationPressed(_ sender: Any) {
    
        
        let VC = storyboard?.instantiateViewController(withIdentifier: "MapID") as! MapsViewController
        VC.selectionDelegate = self
        let NavObj = UINavigationController(rootViewController: VC)
        self.present(NavObj, animated: true)
        
    }

    @IBAction func LeaveBtnPressed(_ sender: Any) {
        
        print("Signout button pressed")
        UserDefaults.standard.set(nil, forKey: "id")
        UserDefaults.standard.synchronize()
        
        self.performSegue(withIdentifier: "gotoViewController", sender: self)
        
    }
    
}
extension AddressOfServiceVC: AddressSelectionDelegate {
    

    func didTapAddress(Address: String, DetailAddress: String) {
        
        AddressArray.singleton.addressArray.removeAll()
        AddressArray.singleton.roomDetailsArray.removeAll()
        
        let addressobj = Address_RoomsDetail()
        addressobj.AddressName = Address
        addressobj.AddressDetail = DetailAddress
        AddressArray.singleton.addressArray.append(addressobj)
        //self.AddressTableView.reloadData()
    }
    
    @IBAction func unwindToAddressOfServices(unwind: UIStoryboardSegue){
        
    }
    
}


