//
//  ChooseProviderTVC.swift
//  Maidpicker
//
//  Created by Apple on 29/10/2018.
//  Copyright © 2018 devstop. All rights reserved.
//

import UIKit

protocol BidSelectionProtocol{
    func bidSelection(index: Int, SPid: Int, Price: Int)
}

class ChooseProviderTVC: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var ClientName: UILabel!
    @IBOutlet weak var jobPerformed: UILabel!
    @IBOutlet weak var AverageRating: UILabel!
    @IBOutlet weak var Reviews: UILabel!
    @IBOutlet weak var SelectPrice: UILabel!
    @IBOutlet weak var starView: SwiftyStarRatingView!
    
    @IBOutlet weak var SelectButton: UIButton!
    
    var cellDelegate: BidSelectionProtocol?
    var indexpath: IndexPath?
    var serviceProviderID: Int?
    var price: Int?
    var check: Bool = true
    
    
    @IBAction func bidSelectionBtnPressed(_ sender: Any) {
        cellDelegate?.bidSelection(index: (indexpath?.row)!, SPid: serviceProviderID!, Price: price!)
        if(check){
            self.SelectButton.isEnabled = false
        }
    }
    
}
