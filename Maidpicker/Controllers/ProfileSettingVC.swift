//
//  ProfileSettingVC.swift
//  Maidpicker
//
//  Created by Apple on 19/09/2018.
//  Copyright © 2018 devstop. All rights reserved.
//

import UIKit
import AWSS3

class ProfileSettingVC: UIViewController, UINavigationControllerDelegate {

    // OUTLETS
    
    @IBOutlet weak var NameTF: UITextField!
    @IBOutlet weak var ContactTF: UITextField!
    @IBOutlet weak var EmailTF: UITextField!
    @IBOutlet weak var zipCodeTF: UITextField!
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
        

        if let image = User.userInstance.userImage{
            self.profileImage.contentMode = .scaleAspectFill
            self.profileImage.layer.cornerRadius = (self.profileImage.frame.size.width)/2
            self.profileImage.clipsToBounds = true
            self.profileImage.image = image
        }
        if let name = User.userInstance.name{
            NameTF.placeholder = name
        }
        if let contact = User.userInstance.mobilephone{
            ContactTF.placeholder = contact
        }
        if let email = User.userInstance.email{
            EmailTF.placeholder = email
        }
        if let zipcode = User.userInstance.zipcode{
            zipCodeTF.placeholder = zipcode
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
        
        print("Signout button pressed")
        UserDefaults.standard.set(nil, forKey: "id")
        UserDefaults.standard.synchronize()
        
        self.performSegue(withIdentifier: "gotoViewController", sender: self)
        
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
            let zipcode = zipCodeTF.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            
        else {
                print("Form is not Valid")
                return
        }
        
        self.S3UploadKeyName = "\(User.userInstance.Userid).png"
        let imageurl = "\(self.S3UploadKeyName)"
        print("this is imageURL: \(imageurl)")
        
        
        if(email == User.userInstance.email){
            
            AuthServices.instance.updateProfile(name: name, email: email, mobilephone: contact, zipcode: zipcode, image: imageurl) { (success) in
                if(success){
                    self.uploadImage(with: UIImagePNGRepresentation(self.imageupload!)!)
                    self.performSegue(withIdentifier: "gotoSettingCenterAfterUpdate", sender: self)
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
    
    
    //  METHOD TO DISABLE KEYBOARD
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}


extension ProfileSettingVC: UIImagePickerControllerDelegate {
    
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


