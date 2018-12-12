//
//  messagesChat.swift
//  Maidpicker
//
//  Created by Apple on 06/12/2018.
//  Copyright © 2018 devstop. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase


class messagesChat: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var messagesChatTableView: UITableView!
    @IBOutlet weak var bottomAnchorTableView: NSLayoutConstraint!
    
    // ========================= VARIABLES =============================
    
    private let cellId = "cellId"
    let containerView = UIView()
    var messages: [String] = []
    var dataObject = chatInboxModel()
    var heightconstraints: CGFloat = 0.0
    
    lazy var messageTextField: UITextField = {
        
        let textField = UITextField()
        textField.placeholder = "Enter Message Here ... "
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        return textField
        
    }()
    
    // ========================= VIEW DID APPEAR =============================
    
    override func viewDidAppear(_ animated: Bool) {
        clientChatModel.instance.chatArray.removeAll()
        self.observeMessages()
    }
    
    // ========================= VIEW WILL APPEAR ============================
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationItem.title = "Chat"
        self.navigationController!.navigationBar.isHidden = false
    }
    
    // ========================= VIEW DID LOAD =============================
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messagesChatTableView.delegate = self
        messagesChatTableView.dataSource = self
        
        setupInputComponents()
        
        // adding tap gesture to tableviewcell
        let tapGesture: UIGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tableCellTapped))
        self.messagesChatTableView.addGestureRecognizer(tapGesture)
        
        
        messagesChatTableView.register(ChatbaseCell.self, forCellReuseIdentifier: cellId)
        
        self.messagesChatTableView.backgroundColor = UIColor.white
        
        print(dataObject.key!)
        
    }
    
    // ========================= CONTAINER VIEW FUNCTIONS =============================
    
    func setupInputComponents() {
        //        let containerView = UIView()
        containerView.backgroundColor = UIColor.white
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(white: 0.85, alpha: 1)
//        view.backgroundColor = .clear

        view.addSubview(containerView)
        
        containerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        containerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        // adding Send button
        
        let sendButton = UIButton(type: .system)
        sendButton.setTitle("Send", for: .normal)
        sendButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        sendButton.backgroundColor = #colorLiteral(red: 0.6849097013, green: 0.8780232072, blue: 0.9137651324, alpha: 1)
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
    
    // ========================= OBJECTIVE C FUNCTIONS =============================
    
    
    @objc func tableCellTapped(){
        self.messageTextField.endEditing(true)
    }
    
    @objc func sendButtonTapped() {
        
        let ref = Database.database().reference()
        let senderRef = ref.child("messages").child("c_\(User.userInstance.Userid!)").child(self.dataObject.key!).childByAutoId()
        let autoID = senderRef.key
        let type = "text"
        print(autoID)
        let RecieverRef = ref.child("messages").child(self.dataObject.key!).child("c_\(User.userInstance.Userid!)").child("\(autoID)")
        
        // Message dataBase
        let values: [String : Any] = ["from": "c_\(User.userInstance.Userid!)",
            "message": messageTextField.text!,
            "seen": false,
            "time": ServerValue.timestamp(),
            "type": type
        ]
        
        senderRef.updateChildValues(values)
        RecieverRef.updateChildValues(values)
        print(messageTextField.text)
        
        // ==================== USER DATABASE ====================
        let UserRefClient = ref.child("Users").child("c_\(User.userInstance.Userid!)")
        let UserValuesClient: [String: Any] = [
            
            "image": User.userInstance.imageURL!,
            "name": User.userInstance.name!,
            "token": User.userInstance.fcmToken!
            
        ]
        let UserRefSP = ref.child("Users").child(self.dataObject.key!)
        let UserValuesSP: [String: Any] = [
            
            "image": self.dataObject.image,
            "name": self.dataObject.name,
            "token": self.dataObject.token
            
        ]
        
        UserRefClient.updateChildValues(UserValuesClient)
        UserRefSP.updateChildValues(UserValuesSP)
        
        // =============== CHAT DATABASE ==================
        
        let senderRefChat = ref.child("Chat").child("c_\(User.userInstance.Userid!)").child(self.dataObject.key!)
        let RecieverRefChat = ref.child("Chat").child(self.dataObject.key!).child("c_\(User.userInstance.Userid!)")
        
        // Message dataBase
        let Chatvalues: [String : Any] = [
            "seen": false,
            "timestamp": ServerValue.timestamp()
        ]
        
        senderRefChat.updateChildValues(Chatvalues)
        RecieverRefChat.updateChildValues(Chatvalues)
        
        // ================================================
        self.observeMessages()
        self.messageTextField.text = nil
        self.messageTextField.sendActions(for: .valueChanged)
        
        
    }
   // keyboard height
    var keyBoardHeight: CGFloat?
    
    @objc func keyboardWillAppear(notification: Notification){
        
        // keyboard height
        
        let userInfo = notification.userInfo as? Dictionary<String,AnyObject>
        let frame = userInfo![UIKeyboardFrameEndUserInfoKey]
        let keyboardRect = frame?.cgRectValue
        keyBoardHeight = keyboardRect?.height
        
        self.view.frame.origin.y = -keyBoardHeight!
        
        print("keyboard will appear")
        
        
    }
    
    @objc func keyboardWillDisappear(notification: Notification){
        
        self.view.frame.origin.y = 0
        
        print("keyboard will Disappear")
        
    }
   
    
    // ========================= TEXTFIELD EDIT AND ENDEDIT FUNCTIONS =============================
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        sendButtonTapped()
        return true
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        UIView.animate(withDuration: 0.5, animations: {
            
            NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillAppear(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillDisappear(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
            
            
        }, completion: nil)
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        print("textfield end editing called")
        
        UIView.animate(withDuration: 0.5, animations: {
            
//            NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillDisappear(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
            
        }, completion: nil)
        
    }
    
    // ========================= FETCHING CHAT MESSAGES =============================
    
    func observeMessages() {
        
        clientChatModel.instance.chatArray.removeAll()
        
        let dbRef = Database.database().reference().child("messages")
        let findClientMessagesRef = dbRef.child("c_\(User.userInstance.Userid!)").child(self.dataObject.key!)
        
        
        findClientMessagesRef.observeSingleEvent(of: DataEventType.childAdded, with: { (snapshot) in
            
            
            
        }, withCancel: nil)
        
//        findClientMessagesRef.observeSingleEvent(of: .value, with: { (snapshot) in
//            print("snapshot is = \(snapshot)")
//
//
//            let children = snapshot.children
//            var yourArray = [[String: Any]]()
//            while let rest = children.nextObject() as? DataSnapshot, let value = rest.value {
//                print("value: \(value)")
//                yourArray.append(value as! [String: Any])
//            }
//
//            for data in yourArray{
//
//                let message = clientChatModel()
//
//                message.from = data["from"] as? String
//                message.message = data["message"] as? String
//                message.seen = data["seen"] as? Int
//                message.time = data["time"] as? Double
//                message.type = data["type"] as? String
//
//                clientChatModel.instance.chatArray.append(message)
//            }
//
//            dump(clientChatModel.instance.chatArray)
//            DispatchQueue.main.async {
//                self.messagesChatTableView.reloadData()
//                self.messagesChatTableView.scrollToRow(at: NSIndexPath(row: clientChatModel.instance.chatArray.count-1, section: 0) as IndexPath, at: .bottom, animated: true)
//            }
//
//        }, withCancel: nil)
        
    }
    
    // ========================= UITABLEVIEW FUNCTIONS =============================
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clientChatModel.instance.chatArray.count
        //        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let messagesArray = clientChatModel.instance.chatArray[indexPath.row]
        let cell = self.messagesChatTableView.dequeueReusableCell(withIdentifier: cellId) as! ChatbaseCell
        
        // =============== ADDING CONSTRAINTS ====================
        
        cell.bubbleBackgroundView.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        cell.bubbleBackgroundView.layer.cornerRadius = 10
        cell.bubbleBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        cell.bubbleBackgroundView.removeFromSuperview()
        cell.messageLabel.removeFromSuperview()
        
        cell.addSubview(cell.bubbleBackgroundView)
        cell.addSubview(cell.messageLabel)
        
        cell.messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        cell.messageLabel.topAnchor.constraint(equalTo: cell.topAnchor, constant: 32).isActive = true
        cell.messageLabel.bottomAnchor.constraint(equalTo: cell.bottomAnchor, constant: -32).isActive = true
        if(clientChatModel.instance.chatArray[indexPath.row].from! == "c_\(User.userInstance.Userid!)"){
            cell.messageLabel.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: -32).isActive = true
            cell.bubbleBackgroundView.backgroundColor = #colorLiteral(red: 0.6849098206, green: 0.8780232072, blue: 0.9137650728, alpha: 1)
        }else{
            cell.messageLabel.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: 32).isActive = true
        }
        cell.messageLabel.widthAnchor.constraint(lessThanOrEqualTo: cell.widthAnchor, multiplier: 0.65).isActive = true
        
        cell.bubbleBackgroundView.topAnchor.constraint(equalTo: cell.messageLabel.topAnchor, constant: -16).isActive = true
        cell.bubbleBackgroundView.leadingAnchor.constraint(equalTo: cell.messageLabel.leadingAnchor, constant: -16).isActive = true
        cell.bubbleBackgroundView.bottomAnchor.constraint(equalTo: cell.messageLabel.bottomAnchor, constant: 16).isActive = true
        cell.bubbleBackgroundView.trailingAnchor.constraint(equalTo: cell.messageLabel.trailingAnchor, constant: 16).isActive = true
        
        // =============== ENDING CONSTRAINTS ====================
        cell.messageLabel.text = messagesArray.message
        cell.backgroundColor = UIColor.clear
        cell.messageLabel.numberOfLines = 0
        
        
        return cell
    }
    
    
    @IBAction func CancelPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}


// ========================= CUSTOM TABLEVIEW CELL ==========================


class ChatbaseCell: UITableViewCell {
    
    let messageLabel = UILabel()
    let bubbleBackgroundView = UIView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
