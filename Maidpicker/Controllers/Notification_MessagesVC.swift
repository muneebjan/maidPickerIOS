//
//  Notification_MessagesVC.swift
//  Maidpicker
//
//  Created by Apple on 19/11/2018.
//  Copyright © 2018 devstop. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class Notification_MessagesVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    
    //  outlets
    @IBOutlet weak var notification_messageTableView: UITableView!
    @IBOutlet weak var segmentC: UISegmentedControl!

    let cellId = "inboxCellID"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController!.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notification_messageTableView.delegate = self
        notification_messageTableView.dataSource = self
        notification_messageTableView.register(InboxCell.self, forCellReuseIdentifier: cellId)

        self.observeMessages()
        print("inbox model array count: \(chatInboxModel.instance.inboxUsersArray.count)")
    }
    
    @IBAction func segmentController(_ sender: Any) {
        
        switch(segmentC.selectedSegmentIndex)
        {
        case 0:
            print("Messages pressed")
            self.notification_messageTableView.reloadData()
            break
        case 1:
            print("Notification pressed")
            self.notification_messageTableView.reloadData()
            break
        default:
            break
        }
        
    }
    
    // UITABLEVIEW FUNCTIONS
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var returnValue = 0
        
        switch segmentC.selectedSegmentIndex {
        case 0:
            //returnValue = messages.count
            returnValue = chatInboxModel.instance.inboxUsersArray.count
            print(returnValue)
            break
        case 1:
            // NOTIFICATION LOGIC HERE
            returnValue = 0
            break
        default:
            break
        }
        return returnValue
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellId) as! InboxCell
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellId, for: indexPath) as! InboxCell
        switch(segmentC.selectedSegmentIndex)
        {
        case 0:
            cell.textLabel?.text = chatInboxModel.instance.inboxUsersArray[indexPath.row].name
            cell.detailTextLabel?.text = chatInboxModel.instance.inboxUsersArray[indexPath.row].token
            //cell?.imageView?.image = UIImage(named: "image.png")
            if let profileimageURL = chatInboxModel.instance.inboxUsersArray[indexPath.row].image{
                let url = URL(string: profileimageURL)
                if let data = try? Data(contentsOf: url!)
                {
                    DispatchQueue.main.async {
                        cell.profileImageView.image = UIImage(data: data)
                    }
                }
            }
    
            
            return cell
            break
        case 1:
            // NOTIFICATION LOGIC HERE
            return cell
            break
        default:
            return cell
            break
        }
        
        return cell

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let chatobject = chatInboxModel.instance.inboxUsersArray[indexPath.row]
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "messageChat") as! messagesChat
        VC.dataObject = chatobject
        self.navigationController?.pushViewController(VC, animated: true)
//        self.present(VC, animated: true, completion: nil)
    }

    // CUSTOM FUNCTIONS

    // ========================= FETCHING CHAT MESSAGES =============================
    
    func observeMessages() {
        
        let UsersdbRef = Database.database().reference().child("Chat").child("c_\(User.userInstance.Userid!)")
        let GetRef_UserInfo = Database.database().reference().child("Users")
        
        UsersdbRef.observeSingleEvent(of: .value) { (snapshot) in
            
            let client = snapshot.key
            for child in snapshot.children {
                
                let child = child as? DataSnapshot
                if let key = child?.key {
                    print("keys are: \(key)")
                    GetRef_UserInfo.child(key).observeSingleEvent(of: .value, with: { (snapshot) in
                        
                        let dict = snapshot.value as! [String: AnyObject]
                        let object = chatInboxModel()
                        
                        object.key = key
                        object.image = dict["image"] as? String
                        object.name = dict["name"] as? String
                        object.token = dict["token"] as? String

                        chatInboxModel.instance.inboxUsersArray.append(object)
                        
                        DispatchQueue.main.async {
                            self.notification_messageTableView.reloadData()
                        }
                        
                    })
                }
                
            }
        }
    }

    // UI-TEXTFIELD METHODS

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    
    
    //  METHOD TO DISABLE KEYBOARD
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
}

// ========================= CUSTOM TABLEVIEW CELL ==========================


class InboxCell: UITableViewCell {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        textLabel?.frame = CGRect(x: 66, y: (textLabel?.frame.origin.y)!, width: (textLabel?.frame.width)!, height: (textLabel?.frame.height)!)
        detailTextLabel?.frame = CGRect(x: 66, y: (detailTextLabel?.frame.origin.y)!, width: (detailTextLabel?.frame.width)!, height: (detailTextLabel?.frame.height)!)
        
    }
    
    let profileImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.layer.cornerRadius = 25
        imageview.layer.masksToBounds = true
        imageview.translatesAutoresizingMaskIntoConstraints = false
        return imageview
    }()

    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        addSubview(profileImageView)
        
        profileImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        profileImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

