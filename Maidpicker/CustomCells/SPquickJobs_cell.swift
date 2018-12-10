//
//  SPquickJobs_cell.swift
//  Maidpicker
//
//  Created by Apple on 26/11/2018.
//  Copyright © 2018 devstop. All rights reserved.
//

import UIKit

protocol tableviewQuickJobbutton{
    //func bidButtonAction(index: Int, bid: Int)
    func bidButtonAction(index: Int)
}

class SPquickJobs_cell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var priceTextfield: UITextField!
    @IBOutlet weak var bedrooms_bathrooms: UILabel!
    
    
    
    @IBOutlet weak var bidButton: UIButton!
    
    var cellDelegate: tableviewQuickJobbutton?
    var indexpath: IndexPath?
    var bidID: Int?
    @IBAction func bidButtonPressed(_ sender: Any) {
        cellDelegate?.bidButtonAction(index: (indexpath?.row)!)
    }
}
