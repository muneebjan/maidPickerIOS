//
//  ongoing_request_offersCell.swift
//  Maidpicker
//
//  Created by Apple on 22/11/2018.
//  Copyright © 2018 devstop. All rights reserved.
//

import UIKit

protocol HirebuttonProtocol{
    func bidHireButton(index: Int, bid: Int)
}

class ongoing_request_offersCell: UITableViewCell {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var ClientName: UILabel!
    @IBOutlet weak var jobPerformed: UILabel!
    @IBOutlet weak var AverageRating: UILabel!
    @IBOutlet weak var Reviews: UILabel!
    @IBOutlet weak var OfferPrice: UILabel!
    @IBOutlet weak var starView: SwiftyStarRatingView!
    @IBOutlet weak var HireButton: UIButton!
    
    var cellDelegate: HirebuttonProtocol?
    var indexpath: IndexPath?
    var bidID: Int?

    @IBAction func HireButtonPressed(_ sender: Any) {
        //cellDelegate?.bidButtonAction(index: (indexpath?.row)!)
        cellDelegate?.bidHireButton(index: (indexpath?.row)!, bid: bidID!)
    }
    
}
