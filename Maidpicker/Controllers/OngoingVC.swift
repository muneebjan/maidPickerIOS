//
//  OngoingVC.swift
//  Maidpicker
//
//  Created by Apple on 13/11/2018.
//  Copyright © 2018 devstop. All rights reserved.
//

import UIKit

class OngoingVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var ongoingTableView: UITableView!
    @IBOutlet weak var segmentcontrol: UISegmentedControl!
    
    @IBAction func Segmented(_ sender: Any) {
        ongoingTableView.reloadData()
    }
    
    //  VIEW WILL APPEAR
    override func viewWillAppear(_ animated: Bool) {
        
        BiddingDataModel.instance.biddingArray.removeAll()
        
        if let id = User.userInstance.Userid{
            AuthServices.instance.getOffersData(id: Int(id)!) { (success) in
                if(success){
                    print("getting Offers Data 1")
                    self.ongoingTableView.reloadData()
                }else{
                    print("not getting offer data")
                }
            }
        }
    }
    
    
    
// viewdidload
    override func viewDidLoad() {
        super.viewDidLoad()
        ongoingTableView.delegate = self
        ongoingTableView.dataSource = self
        
        //offersObject = createOffersArray()
        print("this is userID: \(User.userInstance.Userid!)")

    }
    
    
    // UITABLEVIEW FUNCTIONS
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var returnValue = 0
        
        switch(segmentcontrol.selectedSegmentIndex)
        {
        case 0:
            //returnValue = privateList.count
            break
        case 1:
            //returnValue = friendsAndFamily.count
            break
            
        case 2:
            print("request pressed")
            returnValue = BiddingDataModel.instance.biddingArray.count
            //returnValue = offersObject.count
            break
            
        default:
            break
            
        }
        
        return returnValue
        
        //return offersObject.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let bidArray = BiddingDataModel.instance.biddingArray[indexPath.row]

        if let cell = tableView.dequeueReusableCell(withIdentifier: "ongoingIdentifier") as? ongoingTVC{
            
            switch(segmentcontrol.selectedSegmentIndex)
            {
            case 0:
                //returnValue = privateList.count
                return cell
                break
            case 1:
                //returnValue = friendsAndFamily.count
                return cell
                break
                
            case 2:
//                cell.offerDetailLabel.text = offerobject.offerDetails
                cell.offerDetailLabel.text = BiddingDataModel.instance.DetailArray[indexPath.row].joined(separator: ", ")
                cell.datetimeLabel.text = "\(bidArray.month) \(bidArray.day), 2018"
                cell.priceLabel.text = "$\(bidArray.price)"
                cell.offerLabel.text = "\(bidArray.totalOffers)"
                cell.cellDelegate = self
                cell.indexpath = indexPath
                cell.bidID = bidArray.bidID
                
                return cell
                break
                
            default:
                return cell
                break
            }
            


        }
        else{
            return ongoingTVC()
        }
    }
}

extension OngoingVC: tableviewbutton{
    func cancelrequestbutton(index: Int, bid: Int) {
        print("this is index: \(index), bid ID: \(bid)")
        AuthServices.instance.CancelBidRequest(id: bid) { (success) in
            if(success){
                print("api success")
            }else{
                print("api not success")
            }
        }
    }
}

