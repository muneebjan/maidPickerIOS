//
//  Ongoing_Upcoming_Review.swift
//  Maidpicker
//
//  Created by Apple on 13/12/2018.
//  Copyright © 2018 devstop. All rights reserved.
//

import UIKit

class Ongoing_Upcoming_Review: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var starReview: SwiftyStarRatingView!
    @IBOutlet weak var textView: UITextView!
    
    var spid: Int?
    var imageURL: String?
    var rating: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("iamge url: \(self.imageURL!)")
        self.profileImage.layer.cornerRadius = 25
        self.profileImage.clipsToBounds = true
        self.profileImage.contentMode = .scaleAspectFill
        self.profileImage.image = #imageLiteral(resourceName: "image")
//        if let image = self.imageURL{
//            let url = URL(string: image)
//            if let data = try? Data(contentsOf: url!)
//            {
//                self.profileImage.image = UIImage(data: data)
//            }
//        }else{
//            self.profileImage.image = #imageLiteral(resourceName: "image")
//        }
        self.starReview.allowsHalfStars = false
        self.starReview.addTarget(self, action: #selector(self.starFunction), for: .valueChanged)
        
        
    }
    
    @objc func starFunction() {
        print("messageButton Clicked")
        self.rating = Int(self.starReview.value)
    }
    @IBAction func ConfirmPressed(_ sender: Any) {
        print(self.rating)
        print(self.spid)
        print(self.textView.text)
    
        AuthServices.instance.Ongoing_Upcoming_ReviewPosting(spid: self.spid!, rating: self.rating!, remarks: self.textView.text) { (success) in
            if(success){
                print("Review Posted successfull")
                AuthServices.instance.Get_Notifications(myNotificationUrl: URL_Order_Review, senderId: Int(User.userInstance.Userid!)!, receiverId: self.spid!, type: "clients", completion: { (success) in
                    if(success){
                        print("notification sent Successfull (Review)")
                        self.performSegue(withIdentifier: "gotoOngoing", sender: self)
                    }else{
                        print("notification not sent")
                    }
                })
            }else{
                print("Review Posted Not Successfull")
            }
        }
        
    }
    
    //  METHOD TO DISABLE KEYBOARD
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func backbutton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
