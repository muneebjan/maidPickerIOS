//
//  ongoingTVC.swift
//  Maidpicker
//
//  Created by Apple on 13/11/2018.
//  Copyright © 2018 devstop. All rights reserved.
//

import UIKit

protocol tableviewbutton{
    func cancelrequestbutton(index: Int, bid: Int)
}

class ongoingTVC: UITableViewCell {

    @IBOutlet weak var offerDetailLabel: UILabel!
    @IBOutlet weak var datetimeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var offerLabel: UILabel!
    @IBOutlet weak var CancelRequestBtn: UIButton!
    
    var cellDelegate: tableviewbutton?
    var indexpath: IndexPath?
    var bidID: Int?
    
    @IBAction func cancelBtnPressed(_ sender: Any) {
        cellDelegate?.cancelrequestbutton(index: (indexpath?.row)!, bid: bidID!)
    }
    
}
