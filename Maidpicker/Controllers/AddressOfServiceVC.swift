//
//  AddressOfServiceVC.swift
//  Maidpicker
//
//  Created by Apple on 19/09/2018.
//  Copyright © 2018 devstop. All rights reserved.
//

import UIKit

class AddressDetail {
    
    var AddressName: String = ""
    var AddressDetail: String = ""
    var room: UIImage?
    var bath: UIImage?
    var area: UIImage?
}

class AddressOfServiceVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    

    @IBOutlet weak var AddressTableView: UITableView!
    
    var address: [AddressDetail] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        AddressTableView.delegate = self
        AddressTableView.dataSource = self
        
        
    }
    
    // Table view functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return address.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "addressIdentifier") as? LocationAddTVC{
            
            cell.AddressLabel.text = address[indexPath.row].AddressName
            cell.detailedAddressLabel.text = address[indexPath.row].AddressDetail
            cell.rooms.image = UIImage(named: "room.png")
            cell.bathrooms.image = UIImage(named: "bath.png")
            cell.area.image = UIImage(named: "area.png")
            cell.layer.borderColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
            
            return cell
            
        }
        else{
            return LocationAddTVC()
        }
        
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
extension AddressOfServiceVC: AddressSelectionDelegate{

    func didTapAddress(Address: String, DetailAddress: String) {
        let obj = AddressDetail()
        obj.AddressName = Address
        obj.AddressDetail = DetailAddress
        address.append(obj)
        self.AddressTableView.reloadData()
    }
    
    
}


