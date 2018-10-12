//
//  MapsViewController.swift
//  Maidpicker
//
//  Created by Apple on 20/09/2018.
//  Copyright © 2018 devstop. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

protocol AddressSelectionDelegate {
    func didTapAddress(Address: String, DetailAddress: String)
}

class MapsViewController: UIViewController, CLLocationManagerDelegate {
    
    
    @IBOutlet weak var SearchTextField: UITextField!
    
    var resultsViewController: GMSAutocompleteResultsViewController?
    var searchController: UISearchController?
    var resultView: UITextView?
    var mapView: GMSMapView?
    var locationManager = CLLocationManager()
    
    var selectionDelegate: AddressSelectionDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Present the Autocomplete view controller when the button is pressed.
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        
        let camera = GMSCameraPosition.camera(withLatitude: (self.locationManager.location?.coordinate.latitude)!, longitude: (self.locationManager.location?.coordinate.longitude)!, zoom: 5.0)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView?.settings.myLocationButton = true
        mapView?.isMyLocationEnabled = true
        view = mapView
        
        
    }
    
    func pointingMarker(name: String,coordinates: CLLocationCoordinate2D) {
        //Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = coordinates
        marker.title = name
        //marker.snippet = "Islamabad"
        marker.map = mapView
    }
    
    @IBAction func autoCompleteClicked(_ sender: Any) {
        
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        let filter = GMSAutocompleteFilter()
        filter.type = .establishment  //suitable filter type
        filter.country = "PK"  //appropriate country code
        autocompleteController.autocompleteFilter = filter
        present(autocompleteController, animated: true, completion: nil)
        
    }
    @IBAction func CancelButton(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
}

extension MapsViewController: GMSAutocompleteViewControllerDelegate, CustomAlertViewDelegate {
    
    
    
    func okButtonTapped(roomTextField: String, bathroomTextField: String, otherRoomTextField: String, AreaTextfield: String) {
        
        //roomdataDelegate.sendRoomsData(nRooms: roomTextField, nBathrooms: bathroomTextField, totalArea: AreaTextfield)
        print("rooms are: \(roomTextField)")
        print("bathroom are: \(bathroomTextField)")
        print("bathroom are: \(otherRoomTextField)")
        print("area are: \(AreaTextfield)")
        print("address is: \(AddressArray.singleton.addressArray[0].AddressName)")
        print("detail address is: \(AddressArray.singleton.addressArray[0].AddressDetail)")
        
        let obj = RoomDetails()
        obj.numberOfRooms = roomTextField
        obj.numberOfBathrooms = bathroomTextField
        obj.otherRooms = otherRoomTextField
        obj.AreaOfRoom = AreaTextfield

        AddressArray.singleton.roomDetailsArray.append(obj)
        
        let address = AddressArray.singleton.addressArray[0].AddressName
        let Detailedaddress = AddressArray.singleton.addressArray[0].AddressDetail
        
        AuthServices.instance.add_Address(uid: User.userInstance.Userid!, address1: address!, address2: Detailedaddress!, rooms: roomTextField, washrooms: bathroomTextField, otherroom: otherRoomTextField, area: AreaTextfield) { (success) in
            if(success){
                print("address added successfull")
            }else{
                print("not successfuly")
            }
        }
    
        AddressArray.singleton.addressArray.removeAll()
        AddressArray.singleton.roomDetailsArray.removeAll()
        // unwind segue
        self.performSegue(withIdentifier: "gotoAddressofServices", sender: self)
    }


    func cancelButtonTapped() {
        AddressArray.singleton.addressArray.removeAll()
        print("cancel button pressed")
    }
    

    
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        var firstAddress = ""
        var city = ""
        var country = ""
        var secondAddress = ""
        print("Place name: \(place.name)")
        print("Place Coordinates: \(place.coordinate)")
        var keys = [String]()
        place.addressComponents?.forEach{keys.append($0.type)}
        var values = [String]()
        place.addressComponents?.forEach({ (component) in
            keys.forEach{ component.type == $0 ? values.append(component.name): nil}
            
            print("All component type \(component.type)")
            
            if component.type == "locality"{
                print("This is city name \(component.name)")
                city = component.name
            }
            if component.type == "country"{
                print("This is country name \(component.name)")
                country = component.name
            }
        })
        
        secondAddress = "\(city), \(country)"
        firstAddress = place.name
        print(secondAddress)
        
        selectionDelegate.didTapAddress(Address: firstAddress, DetailAddress: secondAddress)
        self.pointingMarker(name: place.name, coordinates: place.coordinate)
        
        dismiss(animated: true, completion: nil)
        
// ============================ custom AlertView dialog Box =============================
        
        let customAlert = self.storyboard?.instantiateViewController(withIdentifier: "CustomAlertID") as! CustomAlertView
        customAlert.providesPresentationContextTransitionStyle = true
        customAlert.definesPresentationContext = true
        customAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        customAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        customAlert.delegate = self
        self.present(customAlert, animated: true, completion: nil)
    
// ======================================================================================

    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}

