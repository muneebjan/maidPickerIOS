//
//  SetPriceVC.swift
//  Maidpicker
//
//  Created by Apple on 09/11/2018.
//  Copyright © 2018 devstop. All rights reserved.
//

import UIKit

class SetPriceVC: UIViewController {

    @IBOutlet weak var setpriceTextfield: UITextField!
    var price: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func confirmBtnPressed(_ sender: Any) {
        if let data = setpriceTextfield.text{
            self.price = Int(data)!
        }
        print(self.price)
        if((self.price == nil) || (self.price == 0)){
            self.displayMyAlertMessage(userMessage: "Please Enter Price")
        }else{
            
            AuthServices.instance.BiddingAPI(userid: User.userInstance.Userid!, addressid: Extras.singleton.addressID!, whenId: WhenModel.singleton.whenID!, tasksizeID: TaskSizeModel.singleton.TaskSizeID!, Often: HowOften_Extra_Model.singleton.howOften!, serviceProviderID: 0, photo1: SpecialServiceModel.singleton.photoArray[0], photo2: SpecialServiceModel.singleton.photoArray[1], photo3: SpecialServiceModel.singleton.photoArray[2], deepclean: ExtraModel.singleton.deepcleanId, insideCabinet: ExtraModel.singleton.insideCabinetId, insideFridge: ExtraModel.singleton.insideFridgeId, insideOven: ExtraModel.singleton.insideOvenId, laundry: ExtraModel.singleton.LaundryId, window: ExtraModel.singleton.interiorWindowId, allrooms: SpecialServiceModel.singleton.allrooms!, area: SpecialServiceModel.singleton.squarefeets!, notes: SpecialServiceModel.singleton.description!, totalPrice: self.price, status: "posted") { (success) in
                if(success){
                    print("BID SUCCESSFULL")
                    Extras.singleton.removingID()
                    self.performSegue(withIdentifier: "helloGotoHome", sender: self)
                }else{
                    print("Bid not successfull")
                }
            }
        }
    }
    
    
    //  METHOD TO DISABLE KEYBOARD
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // DISPLAY ALERT FUNCTION
    
    func displayMyAlertMessage(userMessage: String) {
        var myalert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        
        myalert.addAction(okAction)
        present(myalert, animated: true, completion: nil)
        
    }
    
}
