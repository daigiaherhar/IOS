//
//  Customer.swift
//  ProjectIOS
//
//  Created by Tran Thang on 7/25/20.
//  Copyright © 2020 OfTung. All rights reserved.
//
import Foundation
import UIKit
class Customer {
    var name:String
    var phone:String
    var address:String
    var email:String
    
    
    init?(name:String, phone:String,address:String,email:String) {
        guard !name.isEmpty else {
            return nil
        }
        guard !phone.isEmpty else {
            return nil
        }
        guard !address.isEmpty else {
            return nil
        }
        guard !email.isEmpty else {
            return nil
        }
        
        self.name = name
        self.phone = phone
        self.address = address
        self.email = email
        
    }
}
