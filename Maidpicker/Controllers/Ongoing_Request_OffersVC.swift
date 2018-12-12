//
//  Ongoing_Request_OffersVC.swift
//  Maidpicker
//
//  Created by Apple on 22/11/2018.
//  Copyright © 2018 devstop. All rights reserved.
//

import UIKit

class Ongoing_Request_OffersVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    

    var BIDid: Int = 0
    @IBOutlet weak var OffersTableView: UITableView!
    
    // VIEW WILL APPEAR
    
    override func viewWillAppear(_ animated: Bool) {
        
        offersDataModel.instance.totaloffersData.removeAll()
        print("getting bid ID: \(self.BIDid)")
        AuthServices.instance.gettingAllOffersDataUnderRequests(bidID: self.BIDid) { (success) in
            if(success){
                print("api successfull")
                self.OffersTableView.reloadData()
            }else{
                print("not successfull")
            }
        }
        
    }
    
    // VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.OffersTableView.delegate = self
        self.OffersTableView.dataSource = self
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return offersDataModel.instance.totaloffersData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let offersobject = offersDataModel.instance.totaloffersData[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ongoing_request_offersCell") as? ongoing_request_offersCell{
            
            cell.profileImage.image = #imageLiteral(resourceName: "image")
            //cell.profileImage.image = providerobject.image
            cell.ClientName.text = offersobject.name
            cell.jobPerformed.text = "Job Performed: \(offersobject.jobs)"
            
            // calculate rating:
            
            if offersobject.review == 0 {
                cell.AverageRating.text = "Average Rating: %0"
                cell.starView.value = 0
            }
            else {
                let avgRating = ((offersobject.rating/(offersobject.review*5))*100)
                cell.AverageRating.text = "Average Rating: %\(avgRating)"
                cell.starView.value = CGFloat((offersobject.rating/offersobject.review))
            }
            
            cell.Reviews.text = "Reviews: \(offersobject.review)"
            cell.OfferPrice.text = "$\(offersobject.price)"
//            cell.cellDelegate = self
            cell.indexpath = indexPath
            cell.bidID = offersobject.bidID
            
            return cell
            
        }
        else{
            return ongoing_request_offersCell()
        }
    }
}

//extension Ongoing_Request_OffersVC: HirebuttonProtocol{
//    func bidHireButton(index: Int, bid: Int) {
//        print("this is index: \(index), bid ID: \(bid)")
////        AuthServices.instance.Ongoing_Request_Hire_Data(bidID: bid) { (success) in
////            if(success){
////                print("Hire Data Api Successfull")
////            }else{
////                print("Not Successfull Hire API")
////            }
////        }
//
//    }
//}
