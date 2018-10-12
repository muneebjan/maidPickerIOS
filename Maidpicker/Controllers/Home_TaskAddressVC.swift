//
//  TaskAddressVC.swift
//  Maidpicker
//
//  Created by Apple on 08/10/2018.
//  Copyright © 2018 devstop. All rights reserved.
//

import UIKit

protocol dataprotocol: class {
    func settingTime(address: String)
}

class Home_TaskAddressVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var taskAddressTableView: UITableView!
    var delegate: dataprotocol?
    // VIEW DID APPEAR
    
    override func viewWillAppear(_ animated: Bool) {
        AddressArray.singleton.addressArray.removeAll()
        AddressArray.singleton.roomDetailsArray.removeAll()
        
        self.gettingDataFromAddressApi()
        
    }
    
    // VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.gettingDataFromAddressApi()
        taskAddressTableView.delegate = self
        taskAddressTableView.dataSource = self
        
    }

    
    func gettingDataFromAddressApi() {
        AuthServices.instance.getAddressbyID(userid: User.userInstance.Userid!) { (success) in
            if(success){
                self.taskAddressTableView.reloadData()
            }else{
                print("some error here")
            }
        }
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AddressArray.singleton.addressArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "taskAddress") as? TaskSizeTVC{
            
            if let addressid = AddressArray.singleton.addressArray[indexPath.row].addressID{
                cell.tag = addressid
            }
            cell.Address.text = AddressArray.singleton.addressArray[indexPath.row].AddressName
            cell.addressDetail.text = AddressArray.singleton.addressArray[indexPath.row].AddressDetail
            cell.roomsImage.image = UIImage(named: "room.png")
            cell.bathroomImage.image = UIImage(named: "bath.png")
            cell.otherRoomImage.image = UIImage(named: "room.png")
            cell.AreaImage.image = UIImage(named: "area.png")
            
            cell.noOfrooms.text = AddressArray.singleton.roomDetailsArray[indexPath.row].numberOfRooms
            cell.noOfBathrooms.text = AddressArray.singleton.roomDetailsArray[indexPath.row].numberOfBathrooms
            cell.noOfOtherrooms.text = AddressArray.singleton.roomDetailsArray[indexPath.row].otherRooms
            cell.AreaOfRoom.text = AddressArray.singleton.roomDetailsArray[indexPath.row].AreaOfRoom
      
            return cell
            
        }
        else{
            return TaskSizeTVC()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! TaskSizeTVC
        print(cell.Address.text)
        if let address = cell.Address.text {
            delegate?.settingTime(address: address)
        }
        print(cell.tag)
        Extras.singleton.addressID = cell.tag
        self.performSegue(withIdentifier: "gotoHomeMain", sender: self)

    }
    
}
