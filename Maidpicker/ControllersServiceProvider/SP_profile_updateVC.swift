//
//  SP_profile_updateVC.swift
//  Maidpicker
//
//  Created by Apple on 25/10/2018.
//  Copyright © 2018 devstop. All rights reserved.
//

import UIKit
import AWSS3

class SP_profile_updateVC: UIViewController, UINavigationControllerDelegate {

    @IBOutlet weak var NameTF: UITextField!
    @IBOutlet weak var ContactTF: UITextField!
    @IBOutlet weak var EmailTF: UITextField!
    @IBOutlet weak var hourlyRate: UITextField!
    @IBOutlet weak var bioTF: UITextView!
    @IBOutlet weak var profileImage: UIImageView!
    
    
    
    var imageupload: UIImage?
    var chooseImgBtnPressCheck: Bool = false
    
    
    //constants
    
    let S3BucketName: String = "maidpickers"
    var S3UploadKeyName: String = "test-image.png"
    
    //S3 Inits
    var completionHandler: AWSS3TransferUtilityUploadCompletionHandlerBlock?
    var progressBlock: AWSS3TransferUtilityProgressBlock?
    let transferUtility = AWSS3TransferUtility.default()
    
    
    // VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()

        
        if let image = ServiceProviderUser.instance.spuserImage{
            self.profileImage.contentMode = .scaleAspectFill
            self.profileImage.layer.cornerRadius = (self.profileImage.frame.size.width)/2
            self.profileImage.clipsToBounds = true
            self.profileImage.image = image
        }
        if let name = ServiceProviderUser.instance.name{
            NameTF.placeholder = name
        }
        if let contact = ServiceProviderUser.instance.contact{
            ContactTF.placeholder = contact
        }
        if let email = ServiceProviderUser.instance.email{
            EmailTF.placeholder = email
        }
        if let hourlyrate = ServiceProviderUser.instance.hourlyrate{
            hourlyRate.placeholder = hourlyrate
        }
        if let bio = ServiceProviderUser.instance.bio{
            bioTF.text = bio
        }
        
        
        // functions
        
        // s3 async
        
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
                    self.displayMyAlertMessage(userMessage: "success")
                }
            })
        }
        
        
    }
    
    
    // ================ BUTTON ACTION =================
    
    @IBAction func LeaveBtnPressed(_ sender: Any) {
        
//        print("Signout button pressed")
//        UserDefaults.standard.set(nil, forKey: "id")
//        UserDefaults.standard.synchronize()
//
//        self.performSegue(withIdentifier: "gotoViewController", sender: self)
        
    }
    
    
    // Camerabutton function
    @IBAction func CameraButton(_ sender: Any) {
        print("camera button pressed")
        
        let picker = UIImagePickerController()

        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        print(S3UploadKeyName)

        present(picker, animated: true, completion: nil)
        
    }
    
    
    // Updatebutton function
    @IBAction func UpdateButton(_ sender: Any) {
        
        guard let name = NameTF.text?.trimmingCharacters(in: .whitespacesAndNewlines),
            let contact = ContactTF.text?.trimmingCharacters(in: .whitespacesAndNewlines),
            let email = EmailTF.text?.trimmingCharacters(in: .whitespacesAndNewlines),
            let hourlyR = hourlyRate.text?.trimmingCharacters(in: .whitespacesAndNewlines),
            let bio = bioTF.text?.trimmingCharacters(in: .whitespacesAndNewlines)

            else {
                print("Form is not Valid")
                return
        }
        
        if let imageid  = ServiceProviderUser.instance.id{
            self.S3UploadKeyName = "P\(imageid).png"
            let imageurl = s3_baseURL+self.S3UploadKeyName
            print("this is imageURL: \(imageurl)")
            ServiceProviderUser.instance.imageURL = imageurl
        }
        

        if(email == ServiceProviderUser.instance.email){
            let hourlyRate = Int(hourlyR)
            print("this is hourly Rate: \(hourlyRate!)")
            AuthServices.instance.ServiceProviderUpdateProfile(name: name, email: email, mobilephone: contact, hourlyrate: hourlyRate!, bio: bio, image: self.S3UploadKeyName) { (success) in
                if(success){
                    if let imageupload = self.imageupload{
                        self.uploadImage(with: UIImagePNGRepresentation(self.resizeImage(image: imageupload, targetSize: CGSize(width: 400, height: 400)))!)
                        self.updatingServiceProvierModel(name: name, contact: contact, email: email, hourlyrate: hourlyR, bio: bio)
                        self.performSegue(withIdentifier: "gotoSP_profileMain", sender: self)
                    }else{
                        print("image not wraaped succesfull")
                    }

                    
                }else{
                    self.displayMyAlertMessage(userMessage: "Update Failed")
                }
            }
        }
        else{
            self.displayMyAlertMessage(userMessage: "Please Type Correct Email Address")
        }


        
    }
    
    // uploadImage function
    
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
    
    // backbutton function
    @IBAction func backBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // ============== END BUTTON ACTION ================
    
    // display ALERT FUNCTION
    
    func displayMyAlertMessage(userMessage: String) {
        var myalert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        myalert.addAction(okAction)
        present(myalert, animated: true, completion: nil)
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
    
    
    //  METHOD TO DISABLE KEYBOARD
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // OTHERS FUNCTIONS
    
    func updatingServiceProvierModel(name: String, contact: String, email: String, hourlyrate: String, bio: String) {
        ServiceProviderUser.instance.name = name
        ServiceProviderUser.instance.contact = contact
        ServiceProviderUser.instance.email = email
        ServiceProviderUser.instance.hourlyrate = hourlyrate
        ServiceProviderUser.instance.bio = bio
    }

}

extension SP_profile_updateVC: UIImagePickerControllerDelegate {

    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {


        if "public.image" == info[UIImagePickerControllerMediaType] as? String {
            self.imageupload = info[UIImagePickerControllerOriginalImage] as! UIImage
            self.profileImage.contentMode = .scaleAspectFill
            self.profileImage.layer.cornerRadius = (self.profileImage.frame.size.width)/2
            self.profileImage.clipsToBounds = true
            self.profileImage.image = self.imageupload
            //self.profileImage.image = self.resizeImage(image: self.imageupload!, targetSize: CGSize(width: 150, height: 150))
            self.chooseImgBtnPressCheck = true

        }


        dismiss(animated: true, completion: nil)
    }
}
