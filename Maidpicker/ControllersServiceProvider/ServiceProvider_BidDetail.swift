//
//  ServiceProvider_BidDetail.swift
//  Maidpicker
//
//  Created by Apple on 23/11/2018.
//  Copyright © 2018 devstop. All rights reserved.
//

import UIKit

class ServiceProvider_BidDetail: UIViewController, UIScrollViewDelegate {

    
    // OUTLETS
    @IBOutlet weak var imageScrollView: UIScrollView!
    @IBOutlet weak var pageController: UIPageControl!
    
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var When: UILabel!
    @IBOutlet weak var taskSize: UILabel!
    @IBOutlet weak var Howoften: UILabel!
    @IBOutlet weak var Extras: UILabel!
    @IBOutlet weak var SpecialServices: UILabel!
    
    var bidId: Int = 0
    
    
    override func viewWillAppear(_ animated: Bool) {
        if(bidId == 0){
            print("no bid id")
        }else{
            AuthServices.instance.getServiceProvider_Bid_Detail(bidId: self.bidId) { (success) in
                if(success){
                    print("api successfull")
                    self.settingLabels()
                }else{
                    print("not successfull")
                }
            }
        }
    }
    
    
    // array of images
    var  images: [String] = ["image","image","image"]
    var frame = CGRect(x: 0, y: 0, width: 0, height: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pageController.numberOfPages = images.count
        
        for index in 0..<images.count{
            frame.origin.x = imageScrollView.frame.size.width * CGFloat(index)
            frame.size = imageScrollView.frame.size
            
            let imageview = UIImageView(frame: frame)
            imageview.image = UIImage(named: images[index])
            imageview.contentMode = .scaleAspectFill
            self.imageScrollView.addSubview(imageview)
        }
        
        imageScrollView.contentSize = CGSize(width: (imageScrollView.frame.size.width * CGFloat(images.count)), height: imageScrollView.frame.size.height)
        
        imageScrollView.delegate = self
        
        self.settingLabels()
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var pageNumber = scrollView.contentOffset.x / scrollView.frame.size.width
        pageController.currentPage = Int(pageNumber)
    }
    
    
    func settingLabels() {
        self.address.text = ServiceProviderBidDetailModel.instance.address1
        self.When.text = "this is when"//ServiceProviderBidDetailModel.instance.wid
        self.taskSize.text = "task size here"
        self.Howoften.text = ServiceProviderBidDetailModel.instance.often
        self.Extras.text = "extra here"
        self.SpecialServices.text = "special services here"
    }
    
}
