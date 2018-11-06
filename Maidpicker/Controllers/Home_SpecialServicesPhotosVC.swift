//
//  Home_SpecialServicesPhotosVC.swift
//  Maidpicker
//
//  Created by Apple on 05/11/2018.
//  Copyright © 2018 devstop. All rights reserved.
//

import UIKit
import AWSS3

class Home_Special_ServicesPhotosVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var SpecialServicesCollectionView: UICollectionView!
    var collectionImage: [UIImage] = [
        UIImage(named: "camera.png")!,
        UIImage(named: "camera.png")!,
        UIImage(named: "camera.png")!
    ]
    var ImagesTobeUploaded: [UIImage] = []
   
    var imageupload: UIImage?
    var indexTrack: Int?
    let S3BucketName: String = "maidpickers"
    var S3UploadKeyName: String = "test-image.png"
    
    //S3 Inits
    var completionHandler: AWSS3TransferUtilityUploadCompletionHandlerBlock?
    var progressBlock: AWSS3TransferUtilityProgressBlock?
    let transferUtility = AWSS3TransferUtility.default()
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.SpecialServicesCollectionView.reloadData()
    }
    
    
    // viewdidload
    override func viewDidLoad() {
        super.viewDidLoad()
        SpecialServicesCollectionView.delegate = self
        SpecialServicesCollectionView.dataSource = self
        
        self.progressBlock = {(task, progress) in
            DispatchQueue.main.async(execute: {
                
                print("Uploading is starting...")
            })
        }
        
        self.completionHandler = { (task, error) -> Void in
            DispatchQueue.main.async(execute: {
                if let error = error {
                    print("Failed with error: \(error)")
                    print("failed")
                }
                    
                else{
                    print("successssss")
//                    self.displayMyAlertMessage(userMessage: "success")
                }
            })
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "specialServicesCell", for: indexPath) as? SpecialServicesCVCell{
            cell.image.layer.masksToBounds = false
            cell.image.layer.cornerRadius = cell.image.frame.height/2
            cell.image.clipsToBounds = true
            cell.image.image = collectionImage[indexPath.row]
            cell.button.tag = indexPath.row
//            StartButton.addTarget(self, action: #selector(self.pressButton(_:)), for: .touchUpInside)
            cell.button.addTarget(self, action: #selector(self.pressButton(_:)), for: .touchUpInside)
            return cell
            
        }else{
            return SpecialServicesCVCell()
        }
    }
    
    @objc func pressButton(_ sender: UIButton){
        print("\(sender.tag)")
        self.indexTrack = sender.tag
        print("camera button pressed")
        
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        print(S3UploadKeyName)
        
        // deleting image in array
        collectionImage.remove(at: sender.tag)
        present(picker, animated: true, completion: nil)
    }
    
    func uploadImage(with data: Data) {
        let expression = AWSS3TransferUtilityUploadExpression()
        
        transferUtility.uploadData(
            data,
            bucket: S3BucketName,
            key: S3UploadKeyName,
            contentType: "image/png",
            expression: expression,
            completionHandler: completionHandler).continueWith { (task) -> AnyObject? in
                if let error = task.error {
                    print("Error: \(error.localizedDescription)")
                    
                    DispatchQueue.main.async {
                        print("failed")
                    }
                }
                
                if let _ = task.result {
                    
                    DispatchQueue.main.async {
                        print("Generating Upload File")
                        print("Upload Starting!")
                        print("Uploading Successful!")
                    }
                    
                    // Do something with uploadTask.
                }
                
                return nil;
        }
    }
    @IBAction func confirmButtonPressed(_ sender: Any) {
        print("image to be uploaded: \(self.ImagesTobeUploaded.count)")
        if(self.ImagesTobeUploaded.count<=0){
            displayMyAlertMessage(userMessage: "Please Select Atleast 1 Photo")
        }else{
            for (index, element) in ImagesTobeUploaded.enumerated(){
                self.S3UploadKeyName = "photos\(index)"
                self.uploadImage(with: UIImagePNGRepresentation(self.resizeImage(image: element, targetSize: CGSize(width: 400, height: 400)))!)
            }
            self.performSegue(withIdentifier: "gotoHomeUnwind", sender: self)
        }

    }
    
}


extension Home_Special_ServicesPhotosVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        
        if "public.image" == info[UIImagePickerControllerMediaType] as? String {
            self.imageupload = info[UIImagePickerControllerOriginalImage] as! UIImage
//            self.profileImage.image = self.imageupload
            //self.profileImage.image = self.resizeImage(image: self.imageupload!, targetSize: CGSize(width: 150, height: 150))
            
        }
        
        self.collectionImage.insert(self.imageupload!, at: self.indexTrack!)
        self.ImagesTobeUploaded.append(self.imageupload!)
        dismiss(animated: true, completion: nil)
        print(self.ImagesTobeUploaded.count)
    }
    
    // method to RESIZE THE IMAGE
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    // display ALERT FUNCTION
    
    func displayMyAlertMessage(userMessage: String) {
        var myalert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        myalert.addAction(okAction)
        present(myalert, animated: true, completion: nil)
    }
    

}
