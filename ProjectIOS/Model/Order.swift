//
//  Order.swift
//  ProjectIOS
//
//  Created by NguyenHuynhHoangSang on 7/26/20.
//  Copyright © 2020 OfTung. All rights reserved.
//

import Foundation
import UIKit
class Order {
    var customerName:String
    var phone:String
    var address:String
    var shoeName:String
    var price:Int
    var amount:Int
    var totalMoney:Int
    var status:String

    init?(customerName:String, phone:String, address:String, shoeName:String, price:Int, amount:Int, totalMoney:Int, status: String) {
        guard !customerName.isEmpty else {
            return nil
        }
        guard !phone.isEmpty else {
            return nil
        }
        guard !address.isEmpty else {
            return nil
        }
        guard !shoeName.isEmpty else {
            return nil
        }
        guard !status.isEmpty else {
            return nil
        }
        
        self.customerName = customerName
        self.phone = phone
        self.address = address
        self.shoeName = shoeName
        self.price = price
        self.amount = amount
        self.totalMoney = totalMoney
        self.status = status
    }
}
