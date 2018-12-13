//
//  OngoingVC.swift
//  Maidpicker
//
//  Created by Apple on 13/11/2018.
//  Copyright © 2018 devstop. All rights reserved.
//

import UIKit

class OngoingVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var ongoingTableView: UITableView!
    @IBOutlet weak var segmentcontrol: UISegmentedControl!
    
    let cellId = "CellID"
    
    @IBAction func Segmented(_ sender: Any) {
        
        switch(segmentcontrol.selectedSegmentIndex)
        {
        case 0:
            print("Upcoming")
            self.ongoingTableView.reloadData()
            break
        case 1:
            print("Past")
            self.ongoingTableView.reloadData()
            break
        case 2:
            print("Request")
            BiddingDataModel.instance.biddingArray.removeAll()
            AuthServices.instance.getOffersData(id: Int(User.userInstance.Userid!)!) { (success) in
                if(success){
                    print("getting Offers Data 1")
                    self.ongoingTableView.reloadData()
                }else{
                    print("not getting offer data")
                }
            }
            break
        default:
            break
        }
        
    }
    
    //  VIEW WILL APPEAR
    override func viewWillAppear(_ animated: Bool) {
        
        if let id = User.userInstance.Userid{
            upcomingModel.instance.DataArray.removeAll()
            AuthServices.instance.Ongoing_Upcoming_Data(userID: Int(id)!) { (sucess) in
                if(sucess){
                    print("api works perfectly")
                    self.ongoingTableView.reloadData()
                }else{
                    print("not success")
                }
            }
        }
    }
    
    
    
// viewdidload
    override func viewDidLoad() {
        super.viewDidLoad()
        ongoingTableView.delegate = self
        ongoingTableView.dataSource = self
        
        //offersObject = createOffersArray()
        print("this is userID: \(User.userInstance.Userid!)")
        ongoingTableView.register(ongoingUpcomingTVC.self, forCellReuseIdentifier: cellId)

    }
    
    
    // UITABLEVIEW FUNCTIONS
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var returnValue = 0
        
        switch(segmentcontrol.selectedSegmentIndex)
        {
        case 0:
            print("Upcoming Pressed")
            returnValue = upcomingModel.instance.DataArray.count
            break
        case 1:
            //returnValue = friendsAndFamily.count
            break
            
        case 2:
            print("request pressed")
            returnValue = BiddingDataModel.instance.biddingArray.count
            //returnValue = offersObject.count
            break
            
        default:
            break
            
        }
        
        return returnValue
        
        //return offersObject.count
    }
    var tableCell: UITableViewCell?
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        switch(segmentcontrol.selectedSegmentIndex)
        {
        case 0:
            let upcomingArray = upcomingModel.instance.DataArray[indexPath.row]
            //let cell = tableView.dequeueReusableCell(withIdentifier: "ongoingIdentifier") as? ongoingTVC
            let cell = tableView.dequeueReusableCell(withIdentifier: self.cellId) as! ongoingUpcomingTVC
            
            // CUSTOMIZE BUTTON
//            cell.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            
//            cell.offerNameLabel.backgroundColor = UIColor.lightGray
//            cell.offerDetailLabel.backgroundColor = UIColor.darkGray
//            cell.progressLabel.backgroundColor = .red
            
            cell.dateLabel.textColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
            cell.dateLabel.textAlignment = .center
            cell.dateLabel.font = UIFont.systemFont(ofSize: 12)
            
            cell.MessageButton.backgroundColor = #colorLiteral(red: 0.6849097013, green: 0.8780232072, blue: 0.9137651324, alpha: 1)
            cell.MessageButton.layer.cornerRadius = 5
            cell.MessageButton.clipsToBounds = true
            cell.MessageButton.setTitleColor(.white, for: .normal)
            cell.MessageButton.setTitle("Message", for: .normal)
            cell.MessageButton.titleLabel?.font =  .systemFont(ofSize: 12)
            
            cell.cancelJobButton.backgroundColor = #colorLiteral(red: 0.6849097013, green: 0.8780232072, blue: 0.9137651324, alpha: 1)
            cell.cancelJobButton.layer.cornerRadius = 5
            cell.cancelJobButton.clipsToBounds = true
            cell.cancelJobButton.setTitleColor(.white, for: .normal)
            cell.cancelJobButton.setTitle("Cancel Job", for: .normal)
            cell.cancelJobButton.titleLabel?.font =  .systemFont(ofSize: 12)
            
            cell.orderMarkButton.backgroundColor = #colorLiteral(red: 0.6849097013, green: 0.8780232072, blue: 0.9137651324, alpha: 1)
            cell.orderMarkButton.setTitle("Mark as Completed", for: UIControlState.normal)

            
            // ADDING SUBVIEW
            cell.addSubview(cell.offerNameLabel)
            cell.addSubview(cell.offerDetailLabel)
            cell.addSubview(cell.progressLabel)
            cell.addSubview(cell.orderMarkButton)
            
            cell.addSubview(cell.dateLabel)
            cell.addSubview(cell.MessageButton)
            cell.addSubview(cell.cancelJobButton)
            // ADDING CONSTRAINTS
            
            // nameLabel
            cell.offerNameLabel.translatesAutoresizingMaskIntoConstraints = false
            cell.offerNameLabel.topAnchor.constraint(equalTo: cell.topAnchor, constant: 16).isActive = true
            cell.offerNameLabel.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: 16).isActive = true
            cell.offerNameLabel.bottomAnchor.constraint(equalTo: cell.offerDetailLabel.topAnchor, constant: -8).isActive = true
            cell.offerNameLabel.widthAnchor.constraint(equalTo: cell.widthAnchor, multiplier: 0.7).isActive = true
            
            //OfferDetailLabel
            cell.offerDetailLabel.translatesAutoresizingMaskIntoConstraints = false
            cell.offerDetailLabel.topAnchor.constraint(equalTo: cell.offerNameLabel.bottomAnchor).isActive = true
            cell.offerDetailLabel.bottomAnchor.constraint(equalTo: cell.progressLabel.topAnchor, constant: -8).isActive = true
            cell.offerDetailLabel.leadingAnchor.constraint(equalTo: cell.offerNameLabel.leadingAnchor).isActive = true
            cell.offerDetailLabel.widthAnchor.constraint(equalTo: cell.widthAnchor, multiplier: 0.7).isActive = true

            //ProgressLabel
            cell.progressLabel.translatesAutoresizingMaskIntoConstraints = false
            cell.progressLabel.topAnchor.constraint(equalTo: cell.offerDetailLabel.bottomAnchor, constant: -8).isActive = true
            cell.progressLabel.bottomAnchor.constraint(equalTo: cell.orderMarkButton.topAnchor, constant: -16).isActive = true
            cell.progressLabel.leadingAnchor.constraint(equalTo: cell.offerDetailLabel.leadingAnchor).isActive = true
            cell.progressLabel.widthAnchor.constraint(equalTo: cell.widthAnchor, multiplier: 0.7).isActive = true

            //Order mark as Completed button
            cell.orderMarkButton.translatesAutoresizingMaskIntoConstraints = false
            cell.orderMarkButton.topAnchor.constraint(equalTo: cell.progressLabel.bottomAnchor).isActive = true
            cell.orderMarkButton.bottomAnchor.constraint(equalTo: cell.bottomAnchor).isActive = true
            cell.orderMarkButton.leadingAnchor.constraint(equalTo: cell.leadingAnchor).isActive = true
            cell.orderMarkButton.trailingAnchor.constraint(equalTo: cell.trailingAnchor).isActive = true
            
            // Date label
            cell.dateLabel.translatesAutoresizingMaskIntoConstraints = false
            cell.dateLabel.topAnchor.constraint(equalTo: cell.topAnchor, constant: 8).isActive = true
            cell.dateLabel.leadingAnchor.constraint(equalTo: cell.offerNameLabel.trailingAnchor, constant: 8).isActive = true
            cell.dateLabel.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: -8).isActive = true
            cell.dateLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
//            cell.dateLabel.bottomAnchor.constraint(equalTo: cell.MessageButton.topAnchor, constant: -8).isActive = true
            
            // MessageButton
            cell.MessageButton.translatesAutoresizingMaskIntoConstraints = false
            cell.MessageButton.topAnchor.constraint(equalTo: cell.dateLabel.bottomAnchor, constant: 8).isActive = true
            cell.MessageButton.leadingAnchor.constraint(equalTo: cell.offerNameLabel.trailingAnchor, constant: 8).isActive = true
            cell.MessageButton.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: -8).isActive = true
            cell.MessageButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
//            cell.MessageButton.bottomAnchor.constraint(equalTo: cell.cancelJobButton.topAnchor, constant: -16).isActive = true
            
            // Cancel Button
            cell.cancelJobButton.translatesAutoresizingMaskIntoConstraints = false
            cell.cancelJobButton.topAnchor.constraint(equalTo: cell.MessageButton.bottomAnchor, constant: 6).isActive = true
            cell.cancelJobButton.leadingAnchor.constraint(equalTo: cell.offerNameLabel.trailingAnchor, constant: 8).isActive = true
            cell.cancelJobButton.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: -8).isActive = true
            cell.cancelJobButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
//            cell.cancelJobButton.bottomAnchor.constraint(equalTo: cell.orderMarkButton.topAnchor, constant: -16).isActive = true
            
            // ASSIGNING VALUES
            cell.cellDelegate = self
            cell.indexpath = indexPath
            cell.spID = upcomingArray.spID
            cell.imageurl = upcomingArray.image
            cell.bidId = upcomingArray.id
            cell.offerNameLabel.text = upcomingArray.name
            cell.offerDetailLabel.text = upcomingModel.instance.DetailArray[indexPath.row].joined(separator: ", ")
            cell.progressLabel.text = "Progess: Booked"
            cell.dateLabel.text = "\(upcomingArray.day),\(upcomingArray.month), 2018"
            tableCell = cell
            return cell
            break
        case 1:
            //returnValue = friendsAndFamily.count
            //return cell
            break
            
        case 2:
            
            let bidArray = BiddingDataModel.instance.biddingArray[indexPath.row]
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "ongoingIdentifier") as? ongoingTVC
                
            print("data: \(BiddingDataModel.instance.DetailArray[indexPath.row])")
            cell!.offerDetailLabel.text = BiddingDataModel.instance.DetailArray[indexPath.row].joined(separator: ", ")
            cell!.datetimeLabel.text = "\(bidArray.month) \(bidArray.day), 2018"
            cell!.priceLabel.text = "$\(bidArray.price)"
            cell!.offerLabel.text = "\(bidArray.totalOffers)"
            cell!.cellDelegate = self
            cell!.indexpath = indexPath
            cell!.bidID = bidArray.bidID
            tableCell = cell!
            return cell!
            break
            
        default:
            //return cell
            break
        }
        return tableCell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch(segmentcontrol.selectedSegmentIndex)
        {
        case 0:
            print("Upcoming Pressed")
            
            break
        case 1:
            //returnValue = friendsAndFamily.count
            print("Past Pressed")
            break
            
        case 2:
            print("request pressed")
            let bidArray = BiddingDataModel.instance.biddingArray[indexPath.row]
            print("this is idnexpath and bidID :\(indexPath.row) & \(bidArray.bidID)")
            
            let VC = storyboard?.instantiateViewController(withIdentifier: "ongoing_request_offers") as! Ongoing_Request_OffersVC
            VC.BIDid = bidArray.bidID
            self.navigationController?.pushViewController(VC, animated: true)
            break
            
        default:
            break
            
        }
        
        
    }

    
    // unwind to Ongoing Request Page
    @IBAction func unwindToOngoing(unwind: UIStoryboardSegue){
        
    }
    
}

extension OngoingVC: tableviewbutton{
    func cancelrequestbutton(index: Int, bid: Int) {
        print("this is index: \(index), bid ID: \(bid)")
        AuthServices.instance.CancelBidRequest(id: bid) { (success) in
            if(success){
                print("api success")
            }else{
                print("api not success")
            }
        }
    }
}

protocol messageUpcomingProtocol{
    func messagePressed(index: Int, SPid: Int)
    func MarkedAsComplete(SpID: Int, id: Int, image: String)
}

class ongoingUpcomingTVC: UITableViewCell {
    
    // VARIABLES
    
    var cellDelegate: messageUpcomingProtocol?
    var indexpath: IndexPath?
    var spID: Int?
    var bidId: Int?
    var imageurl: String?
    
    // VIEWS IN TABLEVIEW CELL
    
    let offerNameLabel = UILabel()
    let offerDetailLabel = UILabel()
    let progressLabel = UILabel()
    let orderMarkButton = UIButton()
    
    let dateLabel = UILabel()
    let MessageButton = UIButton()
    let cancelJobButton = UIButton()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        MessageButton.addTarget(self, action:#selector(self.buttonClicked), for: .touchUpInside)
        orderMarkButton.addTarget(self, action:#selector(self.markAsCompletedButton), for: .touchUpInside)
        
    }
    
       // OBECTIVE C
    @objc func buttonClicked() {
        print("messageButton Clicked")
        cellDelegate?.messagePressed(index: (indexpath?.row)!, SPid: spID!)
    }
    
    @objc func markAsCompletedButton() {
        print("mark as complete pressed")
        cellDelegate?.MarkedAsComplete(SpID: spID!, id: bidId!, image: imageurl!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension OngoingVC: messageUpcomingProtocol{

    @IBAction func unwindTo_OngoingMain(unwind: UIStoryboardSegue){}
    
    
    func messagePressed(index: Int, SPid: Int) {
        print("index: \(index), id: \(SPid)")
        
        let upcomingObject = upcomingModel.instance.DataArray[index]
        let VC = storyboard?.instantiateViewController(withIdentifier: "upcomingchatIndentifier") as! UpcomingChat
        VC.dataObject = upcomingObject
        self.present(VC, animated: true, completion: nil)
        
    }
    
    func MarkedAsComplete(SpID: Int, id: Int, image: String) {
        print("index: \(SpID), id: \(id)")
        
        AuthServices.instance.Ongoing_Upcoming_MarkAsComplete(bid: id) { (success) in
            if(success){
                print("bid marked as completed")
                AuthServices.instance.Get_Notifications(myNotificationUrl: URL_Order_Complete, senderId: Int(User.userInstance.Userid!)!, receiverId: SpID, type: "clients") { (success) in
                    if(success){
                        print("Message Notification Sent Successfull")
                        //reviewScreen
                        let VC = self.storyboard?.instantiateViewController(withIdentifier: "reviewScreen") as! Ongoing_Upcoming_Review
                        VC.spid = SpID
                        VC.imageURL = image
                        self.navigationController?.pushViewController(VC, animated: true)
                    }else{
                        print("Message Notification Not sent Successfull")
                    }
                }
            }else{
                print("api not successfull")
            }
        }
        
//        //reviewScreen
//        let VC = storyboard?.instantiateViewController(withIdentifier: "reviewScreen") as! Ongoing_Upcoming_Review
//        VC.spid = SpID
//        VC.imageURL = image
//        self.navigationController?.pushViewController(VC, animated: true)
    }
    
}
