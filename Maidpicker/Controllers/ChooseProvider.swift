//
//  ChooseProvider.swift
//  Maidpicker
//
//  Created by Apple on 29/10/2018.
//  Copyright © 2018 devstop. All rights reserved.
//

import UIKit

class ChooseProvider: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var chooseProviderTableView: UITableView!
    var providerObject: [providers] = []
    var starImageArray1: [UIImage] = [#imageLiteral(resourceName: "star2"),#imageLiteral(resourceName: "star2"),#imageLiteral(resourceName: "star"),#imageLiteral(resourceName: "star"),#imageLiteral(resourceName: "star")]
    var starImageArray2: [UIImage] = [#imageLiteral(resourceName: "star2"),#imageLiteral(resourceName: "star2"),#imageLiteral(resourceName: "star2"),#imageLiteral(resourceName: "star2"),#imageLiteral(resourceName: "star")]
    override func viewDidLoad() {
        super.viewDidLoad()
        chooseProviderTableView.delegate = self
        chooseProviderTableView.dataSource = self
        
        providerObject = createProviderArray()
        
    }
    
// Creating Provider Array
    func createProviderArray() -> [providers] {
        
        var tempobject: [providers] = []
        
        let object1 = providers.init(image: #imageLiteral(resourceName: "camera"), name: "Hashim John", jobPerformed: "Job Performed: 2", averageRating: "Average Rating: 99%", review: "Reviews: 18", imageArray: self.starImageArray1)
        let object2 = providers.init(image: #imageLiteral(resourceName: "image"), name: "John Doe", jobPerformed: "Job Performed: 5", averageRating: "Average Rating: 97%", review: "Reviews: 4", imageArray: self.starImageArray2)
        
        tempobject.append(object1)
        tempobject.append(object2)
        
        return tempobject
    }
    
    
// UITABLEVIEW FUNCTIONS
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return providerObject.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let providerobject = providerObject[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "chooseproviderIdentifier") as? ChooseProviderTVC{
            
            cell.profileImage.image = providerobject.image
            cell.ClientName.text = providerobject.name
            cell.jobPerformed.text = providerobject.jobPerformed
            cell.AverageRating.text = providerobject.averageRating
            cell.Reviews.text = providerobject.reviews
//            cell.starImageCollection[indexPath.row].image = providerobject.starImage
            for i in 0..<providerobject.starImage.count{
                cell.starImageCollection[i].image = providerobject.starImage[i]
            }
            
            return cell
            
        }
        else{
            return ChooseProviderTVC()
        }
    }

}

extension ChooseProvider{
    class providers {
        
        var image: UIImage
        var name: String
        var jobPerformed: String
        var averageRating: String
        var reviews: String
        var starImage: [UIImage]
        
        init(image: UIImage, name: String, jobPerformed: String, averageRating: String, review: String, imageArray: [UIImage]) {
            self.image = image
            self.name = name
            self.jobPerformed = jobPerformed
            self.averageRating = averageRating
            self.reviews = review
            self.starImage = imageArray
        }
    }
}
