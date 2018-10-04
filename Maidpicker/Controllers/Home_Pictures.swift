//
//  Home_Pictures.swift
//  Maidpicker
//
//  Created by Apple on 02/10/2018.
//  Copyright © 2018 devstop. All rights reserved.
//

import UIKit

class Home_Pictures: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    // outlets
    @IBOutlet weak var PicturesCollectionView: UICollectionView!
    // variables

    var collectionImage: [UIImage] = [
        UIImage(named: "image.png")!,
        UIImage(named: "image.png")!,
        UIImage(named: "image.png")!,
        UIImage(named: "image.png")!
    ]
    
    
    // viewdidload
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pictureIdentifier", for: indexPath) as? CustomPicturesCollectioncell{
            
            cell.image.image = collectionImage[indexPath.row]
            cell.button.setTitle(String(indexPath.row), for: .normal)
            return cell
            
        }else{
            return CustomPicturesCollectioncell()
        }
    }
}
