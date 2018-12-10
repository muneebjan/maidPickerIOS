//
//  SPbids_cell.swift
//  Maidpicker
//
//  Created by Apple on 23/11/2018.
//  Copyright © 2018 devstop. All rights reserved.
//

import UIKit


protocol tableviewBidbutton{
    //func bidButtonAction(index: Int, bid: Int)
    func bidButtonAction(index: Int)
}

class SPbids_cell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var priceTextfield: UITextField!
    @IBOutlet weak var bedrooms_bathrooms: UILabel!
    
    
    @IBOutlet weak var bidButton: UIButton!
    
    var cellDelegate: tableviewBidbutton?
    var indexpath: IndexPath?
    var bidID: Int?
    
    @IBAction func bidButtonPressed(_ sender: Any) {
        cellDelegate?.bidButtonAction(index: (indexpath?.row)!)
    }
    
}
