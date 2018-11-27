//
//  Notification_MessagesVC.swift
//  Maidpicker
//
//  Created by Apple on 19/11/2018.
//  Copyright © 2018 devstop. All rights reserved.
//

import UIKit

class Notification_MessagesVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //  outlets
    @IBOutlet weak var notification_messageTableView: UITableView!
    @IBOutlet weak var segmentC: UISegmentedControl!
    
    var messages: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notification_messageTableView.delegate = self
        notification_messageTableView.dataSource = self
        
        messages.append("hellow")
        messages.append("helllow1")
        messages.append("helloww2")
        
        setupInputComponents()
    }
    
    @IBAction func segmentController(_ sender: Any) {
        
        switch(segmentC.selectedSegmentIndex)
        {
        case 0:
            print("Messages pressed")
            break
        case 1:
            print("Notification pressed")
            break
        default:
            break
        }
        
    }
    
    // UITABLEVIEW FUNCTIONS
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.notification_messageTableView.dequeueReusableCell(withIdentifier: "messageCell") as! UITableViewCell
        
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
        containerView.bottomAnchor.constraint(equalTo: notification_messageTableView.bottomAnchor).isActive = true
        containerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        // adding Send button
        
        let sendButton = UIButton()
        sendButton.setTitle("Send", for: .normal)
        sendButton.setTitleColor(#colorLiteral(red: 0.6849098206, green: 0.8780232072, blue: 0.9137650728, alpha: 1), for: .normal)
        sendButton.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(sendButton)
        
        // x,y, width , height
        sendButton.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        sendButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        sendButton.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        sendButton.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.25).isActive = true
        
        
        // adding TextField button
        
        let messageTextField = UITextField()
        messageTextField.placeholder = "Enter Message Here ... "
        messageTextField.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(messageTextField)
        
        // x,y, width , height
        messageTextField.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 10).isActive = true
        //messageTextField.leftAnchor.constraint(equalTo: containerView.leftAnchor, equalToConstant: 5).isActive = true
        messageTextField.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        messageTextField.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        messageTextField.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.75).isActive = true
        
        
    }
    
    @objc func sendButtonTapped() {
        NSLog("here i am")
    }
    
}
