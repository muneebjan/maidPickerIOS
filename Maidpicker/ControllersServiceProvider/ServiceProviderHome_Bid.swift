//
//  ServiceProviderHome_Bid.swift
//  Maidpicker
//
//  Created by Apple on 23/11/2018.
//  Copyright © 2018 devstop. All rights reserved.
//

import UIKit

class ServiceProviderHome_Bid: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var bidsTableView: UITableView!
    
    
    
    // VIEW WILL APPEAR
    
    override func viewWillAppear(_ animated: Bool) {
        
        ServiceProviderHomeBidModel.instance.totalBidData.removeAll()
        AuthServices.instance.getServiceProvider_Bid_Data { (success) in
            if(success){
                print("api successfull")
                self.bidsTableView.reloadData()
            }else{
                print("not successfull")
            }
        }
        
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bidsTableView.delegate = self
        bidsTableView.dataSource = self
        
    }

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ServiceProviderHomeBidModel.instance.totalBidData.count
    }
    
    // spBidCell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let bidobject = ServiceProviderHomeBidModel.instance.totalBidData[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "spBidCell") as? SPbids_cell{

            cell.name.text = bidobject.name
            cell.bedrooms_bathrooms.text = "\(bidobject.bedrooms) Bedrooms, \(bidobject.bathrooms) Bathrooms"
            
            cell.date.text = "\(bidobject.month) \(bidobject.day), 2018"
            cell.priceTextfield.placeholder = "\(bidobject.price)"
            cell.cellDelegate = self
            cell.indexpath = indexPath
            
            return cell
            
        }
        else{
            return SPbids_cell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // bidDetail
        
        let VC = storyboard?.instantiateViewController(withIdentifier: "bidDetail") as! ServiceProvider_BidDetail
        //VC.delegate = self
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    //  METHOD TO DISABLE KEYBOARD
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
}

extension ServiceProviderHome_Bid: tableviewBidbutton{
    
    func bidButtonAction(index: Int) {
        print("this is index: \(index)")
    }
    
}
