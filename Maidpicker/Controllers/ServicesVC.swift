//
//  ServicesVC.swift
//  Maidpicker
//
//  Created by Apple on 30/10/2018.
//  Copyright © 2018 devstop. All rights reserved.
//

import UIKit

class ServicesVC: UIViewController {

    @IBOutlet weak var requestbigImage: UIImageView!
    @IBOutlet weak var requestBigLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func requestBidPressed(_ sender: Any) {
        
        AuthServices.instance.BiddingAPI(userid: User.userInstance.Userid!, addressid: Extras.singleton.addressID!, whenId: WhenModel.singleton.whenID!, tasksizeID: TaskSizeModel.singleton.TaskSizeID!, Often: HowOften_Extra_Model.singleton.howOften!, serviceProviderID: 0, photo1: SpecialServiceModel.singleton.photoArray[0], photo2: SpecialServiceModel.singleton.photoArray[1], photo3: SpecialServiceModel.singleton.photoArray[2], deepclean: ExtraModel.singleton.deepcleanId, insideCabinet: ExtraModel.singleton.insideCabinetId, insideFridge: ExtraModel.singleton.insideFridgeId, insideOven: ExtraModel.singleton.insideOvenId, laundry: ExtraModel.singleton.LaundryId, window: ExtraModel.singleton.interiorWindowId, allrooms: SpecialServiceModel.singleton.allrooms!, area: SpecialServiceModel.singleton.squarefeets!, notes: SpecialServiceModel.singleton.description!, totalPrice: 0, status: "posted") { (success) in
            if(success){
                self.requestbigImage.image = UIImage(named: "request bid3")
                self.requestBigLabel.textColor = #colorLiteral(red: 0.7709656358, green: 0.8703430295, blue: 0.5776815414, alpha: 1)
                self.displayMyAlertMessage(userMessage: "BID SUCCESSFULL")
                Extras.singleton.removingID()
            }else{
                print("Bid not successfull")
            }
        }
    }
    
    @IBAction func setPricePressed(_ sender: Any) {
        let VC = storyboard?.instantiateViewController(withIdentifier: "setpriceVC") as! SetPriceVC
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    @IBAction func chooseProviderPressed(_ sender: Any) {
        let VC = storyboard?.instantiateViewController(withIdentifier: "chooseproviderVC") as! ChooseProvider
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    @IBAction func unwindToServiceVC(unwind: UIStoryboardSegue){
    }
    
    // DISPLAY ALERT FUNCTION
    
    func displayMyAlertMessage(userMessage: String) {
        var myalert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        
        myalert.addAction(okAction)
        present(myalert, animated: true, completion: nil)
        
    }
    
}
