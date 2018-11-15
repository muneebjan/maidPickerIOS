//
//  ChooseProvider.swift
//  Maidpicker
//
//  Created by Apple on 29/10/2018.
//  Copyright © 2018 devstop. All rights reserved.
//

import UIKit

class ChooseProvider: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var chooseProviderTableView: UITableView!
    //var providerObject: [providers] = []
    var starImageArray1: [UIImage] = [#imageLiteral(resourceName: "star2"),#imageLiteral(resourceName: "star2"),#imageLiteral(resourceName: "star"),#imageLiteral(resourceName: "star"),#imageLiteral(resourceName: "star")]
    var starImageArray2: [UIImage] = [#imageLiteral(resourceName: "star2"),#imageLiteral(resourceName: "star2"),#imageLiteral(resourceName: "star2"),#imageLiteral(resourceName: "star2"),#imageLiteral(resourceName: "star")]

    
    @IBOutlet weak var ViewforStarRating: UIView!
    
    //  VIEW WILL APPEAR
    override func viewWillAppear(_ animated: Bool) {
        
        ChooseProviderModel.instance.chooseProviderArray.removeAll()
        
        AuthServices.instance.gettingServiceProviderData { (success) in
            if(success){
                print("api successfull")
                self.chooseProviderTableView.reloadData()
            }else{
                print("not successfull")
            }
        }
        
    }
    
    
// VIEW DID LOAD FUNCTION
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chooseProviderTableView.delegate = self
        chooseProviderTableView.dataSource = self
    
        
        
    }
    
    
// UITABLEVIEW FUNCTIONS
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ChooseProviderModel.instance.chooseProviderArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let providerobject = ChooseProviderModel.instance.chooseProviderArray[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "chooseproviderIdentifier") as? ChooseProviderTVC{
            
            
            cell.profileImage.image = #imageLiteral(resourceName: "image")
            //cell.profileImage.image = providerobject.image
            cell.ClientName.text = providerobject.name
            cell.jobPerformed.text = "Job Performed: \(providerobject.jobs)"
            
            // calculate rating:
            
            if providerobject.review == 0 {
                cell.AverageRating.text = "Average Rating: %0"
                cell.starView.value = 0
            }
            else {
                let avgRating = ((providerobject.rating/(providerobject.review*5))*100)
                cell.AverageRating.text = "Average Rating: %\(avgRating)"
                cell.starView.value = CGFloat((providerobject.rating/providerobject.review))
            }
            
            cell.Reviews.text = "Reviews: \(providerobject.review)"
            cell.SelectPrice.text = "Select for $\(providerobject.hourlyrate)/hr"
            cell.cellDelegate = self
            cell.indexpath = indexPath
            cell.price = providerobject.hourlyrate
            cell.serviceProviderID = providerobject.spID
            
            return cell
            
        }
        else{
            return ChooseProviderTVC()
        }
    }

}


extension ChooseProvider: BidSelectionProtocol{
    func bidSelection(index: Int, SPid: Int, Price: Int) {
        
        print("this is index: \(index), ServiceProvider ID: \(SPid)")
        
        AuthServices.instance.BiddingAPI(userid: User.userInstance.Userid!, addressid: Extras.singleton.addressID!, whenId: WhenModel.singleton.whenID!, tasksizeID: TaskSizeModel.singleton.TaskSizeID!, Often: HowOften_Extra_Model.singleton.howOften!, serviceProviderID: SPid, photo1: SpecialServiceModel.singleton.photoArray[0], photo2: SpecialServiceModel.singleton.photoArray[1], photo3: SpecialServiceModel.singleton.photoArray[2], deepclean: ExtraModel.singleton.deepcleanId, insideCabinet: ExtraModel.singleton.insideCabinetId, insideFridge: ExtraModel.singleton.insideFridgeId, insideOven: ExtraModel.singleton.insideOvenId, laundry: ExtraModel.singleton.LaundryId, window: ExtraModel.singleton.interiorWindowId, allrooms: SpecialServiceModel.singleton.allrooms!, area: SpecialServiceModel.singleton.squarefeets!, notes: SpecialServiceModel.singleton.description!, totalPrice: Price, status: "booked") { (success) in
            if(success){
                print("BID SUCCESSFULL")
                Extras.singleton.removingID()
                
            }else{
                print("Bid not successfull")
            }
        }
        
    }

    
//    func cancelrequestbutton(index: Int, bid: Int) {
//        print("this is index: \(index), bid ID: \(bid)")
//        AuthServices.instance.CancelBidRequest(id: bid) { (success) in
//            if(success){
//                print("api success")
//            }else{
//                print("api not success")
//            }
//        }
//    }
}
