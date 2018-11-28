//
//  ChooseProviderChat.swift
//  Maidpicker
//
//  Created by Apple on 28/11/2018.
//  Copyright © 2018 devstop. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase


class ChooseProviderChat: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var chooseProviderChat: UITableView!
    var messages: [String] = []
    var dataObject = ChooseProviderModel()
    
    lazy var messageTextField: UITextField = {
        
        let textField = UITextField()
        textField.placeholder = "Enter Message Here ... "
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        return textField
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.fetchChatMessages()
        
        chooseProviderChat.delegate = self
        chooseProviderChat.dataSource = self
        
        messages.append("hellow")
        messages.append("helllow1")
        messages.append("helloww2")
        
        setupInputComponents()
    }

    // UITABLEVIEW FUNCTIONS  storyboad id: chooseProviderChat ... identifier : chooseProviderChatCell
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.chooseProviderChat.dequeueReusableCell(withIdentifier: "chooseProviderChatCell") as! UITableViewCell
        
        cell.textLabel?.text = self.messages[indexPath.row]
        
        return cell
    }
    
    // CUSTOM FUNCTIONS
    
    func setupInputComponents() {
        let containerView = UIView()
        containerView.backgroundColor = UIColor.white
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(containerView)
        
        containerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: chooseProviderChat.bottomAnchor).isActive = true
        containerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        // adding Send button
        
        let sendButton = UIButton(type: .system)
        sendButton.setTitle("Send", for: .normal)
        sendButton.setTitleColor(#colorLiteral(red: 0.6849098206, green: 0.8780232072, blue: 0.9137650728, alpha: 1), for: .normal)
        //        sendButton.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        sendButton.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(sendButton)
        
        // x,y, width , height
        sendButton.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        sendButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        sendButton.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        sendButton.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.25).isActive = true
        
        
        // adding TextField button
        
        containerView.addSubview(messageTextField)
        
        // x , y , width , height // , constant: 10
        messageTextField.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 8).isActive = true
        messageTextField.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        messageTextField.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        messageTextField.rightAnchor.constraint(equalTo: sendButton.leftAnchor, constant: -5).isActive = true
        
        let separatorLine = UIView()
        separatorLine.backgroundColor = #colorLiteral(red: 0.6849098206, green: 0.8780232072, blue: 0.9137650728, alpha: 1)
        separatorLine.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(separatorLine)
        
        separatorLine.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        separatorLine.bottomAnchor.constraint(equalTo: messageTextField.topAnchor).isActive = true
        separatorLine.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        separatorLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        
    }
    
    @objc func sendButtonTapped() {
        
        let ref = Database.database().reference()
        let senderRef = ref.child("messages").child("c_\(User.userInstance.Userid!)").child("s_\(self.dataObject.spID)").childByAutoId()
        let autoID = senderRef.key
        print(autoID)
        let RecieverRef = ref.child("messages").child("s_\(self.dataObject.spID)").child("c_\(User.userInstance.Userid!)").child("\(autoID)")
        
        let values: [String : Any] = ["from": "c_\(User.userInstance.Userid!)",
            "message": messageTextField.text!,
            "seen": false,
            "time": ServerValue.timestamp(),
            "type": "text"
        ]
        
        senderRef.updateChildValues(values)
        RecieverRef.updateChildValues(values)
        print(messageTextField.text)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        sendButtonTapped()
        return true
    }
    @IBAction func backbutton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // fetching Chat Messages
    
    func fetchChatMessages() {
        let dbRef = Database.database().reference().child("messages")
        let findClientMessagesRef = dbRef.child("c_\(User.userInstance.Userid!)").child("s_\(self.dataObject.spID)")
        findClientMessagesRef.observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
            
            print(snapshot)
            
        }, withCancel: nil)
        
    }
    
    
    
}
