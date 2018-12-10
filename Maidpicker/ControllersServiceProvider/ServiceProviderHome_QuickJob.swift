//
//  ServiceProviderHome_QuickJob.swift
//  Maidpicker
//
//  Created by Apple on 26/11/2018.
//  Copyright © 2018 devstop. All rights reserved.
//

import UIKit

class ServiceProviderHome_QuickJob: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var quickJobTableView: UITableView!
    
    
    
    // VIEW WILL APPEAR
    
    override func viewWillAppear(_ animated: Bool) {
        
        ServiceProviderHomeBidModel.instance.totalBidData.removeAll()
        AuthServices.instance.getServiceProvider_QuickJob_Data { (success) in
            if(success){
                print("api successfull")
                self.quickJobTableView.reloadData()
            }else{
                print("not successfull")
            }
        }
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        quickJobTableView.delegate = self
        quickJobTableView.dataSource = self
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ServiceProviderHomeBidModel.instance.totalBidData.count
    }
    
    // spBidCell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let bidobject = ServiceProviderHomeBidModel.instance.totalBidData[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "spQuickJobCell") as? SPquickJobs_cell{
            
            cell.name.text = bidobject.name
            cell.bedrooms_bathrooms.text = "\(bidobject.bedrooms) Bedrooms, \(bidobject.bathrooms) Bathrooms"
            
            cell.date.text = "\(bidobject.month) \(bidobject.day), 2018"
            cell.priceTextfield.text = "\(bidobject.price)$"
            cell.cellDelegate = self
            cell.indexpath = indexPath
            
            return cell
            
        }
        else{
            return SPquickJobs_cell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // bidDetail
        let bidDetailArray = ServiceProviderHomeBidModel.instance.totalBidData[indexPath.row]
        print("this is idnexpath and bidID :\(indexPath.row) & \(bidDetailArray.Bidid)")
        
        let VC = storyboard?.instantiateViewController(withIdentifier: "bidDetail") as! ServiceProvider_BidDetail
        VC.bidId = bidDetailArray.Bidid
        //VC.delegate = self
        self.navigationController?.pushViewController(VC, animated: true)
    }

}

extension ServiceProviderHome_QuickJob: tableviewQuickJobbutton{
    
    func bidButtonAction(index: Int) {
        print("this is index: \(index)")
    }
    
}
