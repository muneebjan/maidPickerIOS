//
//  Notification_MessagesVC.swift
//  Maidpicker
//
//  Created by Apple on 19/11/2018.
//  Copyright © 2018 devstop. All rights reserved.
//

import UIKit

class Notification_MessagesVC: UIViewController {
    
    @IBOutlet weak var segmentC: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func segmentController(_ sender: Any) {
        
        switch(segmentC.selectedSegmentIndex)
        {
        case 0:
            print("Messages pressed")
            break
        case 1:
            print("Notification pressed")
            break
        default:
            break
            
        }
        
    }
    

}
