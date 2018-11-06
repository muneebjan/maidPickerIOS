//
//  Home_SpecialServicesVC.swift
//  Maidpicker
//
//  Created by Apple on 17/10/2018.
//  Copyright © 2018 devstop. All rights reserved.
//

import UIKit

class Home_SpecialServicesMainVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var SpecialServicesCollectionView: UICollectionView!
    var collectionImage: [UIImage] = [
        UIImage(named: "image.png")!,
        UIImage(named: "image.png")!,
        UIImage(named: "image.png")!,
        UIImage(named: "image.png")!
    ]
    
    
    // viewdidload
    override func viewDidLoad() {
        super.viewDidLoad()
        SpecialServicesCollectionView.delegate = self
        SpecialServicesCollectionView.dataSource = self
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "specialServicesCell", for: indexPath) as? SpecialServicesCVCell{
            
            cell.image.image = collectionImage[indexPath.row]
            cell.button.setTitle(String(indexPath.row), for: .normal)
            return cell
            
        }else{
            return SpecialServicesCVCell()
        }
    }
}
