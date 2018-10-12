//
//  CustomAlertViewDelegate.swift
//  CustomAlertView
//
//  Created by Daniel Luque Quintana on 16/3/17.
//  Copyright © 2017 dluque. All rights reserved.
//

protocol CustomAlertViewDelegate: class {
    func okButtonTapped(roomTextField: String, bathroomTextField: String, otherRoomTextField: String, AreaTextfield: String)
    func cancelButtonTapped()
}
