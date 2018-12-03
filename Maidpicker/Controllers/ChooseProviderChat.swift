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
    @IBOutlet weak var chatTableBottom: NSLayoutConstraint!
    @IBOutlet var mainView: UIView!
    
// ========================= VARIABLES =============================
    
    private let cellId = "cellId"
    
    let containerView = UIView()
    var messages: [String] = []
    var dataObject = ChooseProviderModel()
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
        
        self.observeMessages()
    }
    
    
 // ========================= VIEW DID LOAD =============================
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chooseProviderChat.delegate = self
        chooseProviderChat.dataSource = self
        
        messages.append("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,")
        messages.append("when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.")
        messages.append("It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, any web sites still in their infancy.")
        
        setupInputComponents()
        
        // adding tap gesture to tableviewcell
        let tapGesture: UIGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tableCellTapped))
        self.chooseProviderChat.addGestureRecognizer(tapGesture)
        

        chooseProviderChat.register(baseCell.self, forCellReuseIdentifier: cellId)

        self.chooseProviderChat.backgroundColor = UIColor.white
//        self.chooseProviderChat.translatesAutoresizingMaskIntoConstraints = false
//        self.chooseProviderChat.bottomAnchor.constraint(equalTo: self.containerView.topAnchor).isActive = true
    }



// ========================= CONTAINER VIEW FUNCTIONS =============================
    
    func setupInputComponents() {
//        let containerView = UIView()
        containerView.backgroundColor = UIColor.clear
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(white: 0.85, alpha: 1)
        view.addSubview(containerView)
        
        containerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
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
    
// ========================= OBJECTIVE C FUNCTIONS =============================
    
    
    @objc func tableCellTapped(){
        self.messageTextField.endEditing(true)
    }
    
    @objc func sendButtonTapped() {
        
        let ref = Database.database().reference()
        let senderRef = ref.child("messages").child("c_\(User.userInstance.Userid!)").child("s_\(self.dataObject.spID)").childByAutoId()
        let autoID = senderRef.key
        let type = "text"
        print(autoID)
        let RecieverRef = ref.child("messages").child("s_\(self.dataObject.spID)").child("c_\(User.userInstance.Userid!)").child("\(autoID)")
        
        let values: [String : Any] = ["from": "c_\(User.userInstance.Userid!)",
            "message": messageTextField.text!,
            "seen": false,
            "time": ServerValue.timestamp(),
            "type": type
        ]
        
        senderRef.updateChildValues(values)
        RecieverRef.updateChildValues(values)
        print(messageTextField.text)
        
        self.observeMessages()
        self.messageTextField.endEditing(true)
        
    }
    
    @objc func keyboardWillAppear(notification: Notification){
        
        if let userInfo = notification.userInfo as? Dictionary<String,AnyObject>{
            let frame = userInfo[UIKeyboardFrameEndUserInfoKey]
            let keyboardRect = frame?.cgRectValue
            let keyBoardHeight = keyboardRect?.height
//            if let height = keyBoardHeight{
//                self.heightconstraints = height
//            }
            self.containerView.translatesAutoresizingMaskIntoConstraints = false
            //            self.containerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: self.heightconstraints).isActive = true
            self.containerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -keyBoardHeight!).isActive = true
            self.chatTableBottom.constant = keyBoardHeight!+50
            
        }
        
    }
    
    @objc func keyboardWillDisappear(notification: Notification){
        
        self.containerView.translatesAutoresizingMaskIntoConstraints = false
        self.containerView.topAnchor.constraint(equalTo: self.chooseProviderChat.bottomAnchor, constant: 0).isActive = true
//        self.containerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -keyBoardHeight!).isActive = true
        self.chatTableBottom.constant = 50
        
    }
    
// ========================= TEXTFIELD EDIT AND ENDEDIT FUNCTIONS =============================

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        sendButtonTapped()
        return true
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
//        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.5, animations: {
            
            NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillAppear(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillDisappear(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
            
//            self.containerView.translatesAutoresizingMaskIntoConstraints = false
//            self.containerView.backgroundColor = .green
////            self.containerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: self.heightconstraints).isActive = true
//            self.containerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -350).isActive = true
//            self.chatTableBottom.constant = 400
            
            
        }, completion: nil)
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
//        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.5, animations: {
            
//            self.containerView.translatesAutoresizingMaskIntoConstraints = false
//            self.containerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
//            self.view.layoutIfNeeded()
            
        }, completion: nil)
        
    }
    
    

// ========================= FETCHING CHAT MESSAGES =============================

    func observeMessages() {
        
        clientChatModel.instance.chatArray.removeAll()
        
        let dbRef = Database.database().reference().child("messages")
        let findClientMessagesRef = dbRef.child("c_\(User.userInstance.Userid!)").child("s_\(self.dataObject.spID)")
        
        findClientMessagesRef.observeSingleEvent(of: .value, with: { (snapshot) in
            print("snapshot is = \(snapshot)")
            

            let children = snapshot.children
            var yourArray = [[String: Any]]()
            while let rest = children.nextObject() as? DataSnapshot, let value = rest.value {
                print("value: \(value)")
                yourArray.append(value as! [String: Any])
            }
            
            for data in yourArray{
                
                let message = clientChatModel()
                
                message.from = data["from"] as? String
                message.message = data["message"] as? String
                message.seen = data["seen"] as? Int
                message.time = data["time"] as? Double
                message.type = data["type"] as? String
                
                clientChatModel.instance.chatArray.append(message)
            }
            
            dump(clientChatModel.instance.chatArray)
            DispatchQueue.main.async {
                self.chooseProviderChat.reloadData()
            }

        }, withCancel: nil)
        
    }
    
    
// ========================= UITABLEVIEW FUNCTIONS =============================
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clientChatModel.instance.chatArray.count
//        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let messagesArray = clientChatModel.instance.chatArray[indexPath.row]
//        let messagesArray = messages[indexPath.row]
        
        let cell = self.chooseProviderChat.dequeueReusableCell(withIdentifier: cellId) as! baseCell
        cell.messageLabel.text = messagesArray.message
//        cell.messageLabel.text = messagesArray
        cell.backgroundColor = UIColor.clear
        cell.messageLabel.numberOfLines = 0
        
        return cell
    }
    
    
// ========================= OUTLET FUNCTIONS =============================
    @IBAction func backbutton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

// ========================= CUSTOM TABLEVIEW CELL ==========================


class baseCell: UITableViewCell {

    let messageLabel = UILabel()
    let bubbleBackgroundView = UIView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //
        bubbleBackgroundView.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        bubbleBackgroundView.layer.cornerRadius = 10
        bubbleBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(bubbleBackgroundView)
        addSubview(messageLabel)
//        messageLabel.backgroundColor = .red
        
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 32).isActive = true
        messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32).isActive = true
        messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32).isActive = true
        messageLabel.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor, multiplier: 0.65).isActive = true
        
        //messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32).isActive = true
        //messageLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.65).isActive = true
        
        bubbleBackgroundView.topAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -16).isActive = true
        bubbleBackgroundView.leadingAnchor.constraint(equalTo: messageLabel.leadingAnchor, constant: -16).isActive = true
        bubbleBackgroundView.bottomAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 16).isActive = true
        bubbleBackgroundView.trailingAnchor.constraint(equalTo: messageLabel.trailingAnchor, constant: 16).isActive = true
        
//        messageLabel.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}





extension UIView {
    
    func addConstraintsWithFormat(format: String, views: UIView...) {
        
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
    }
    
}

