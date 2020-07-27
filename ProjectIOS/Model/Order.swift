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
    var price:String
    var amount:String
    var totalMoney:String
    var status:String
//    var imageShoe:UIImage

    init?(customerName:String, phone:String, address:String, shoeName:String, price:String, amount:String, totalMoney:String, status: String) {
        guard !customerName.isEmpty else {
            return nil
        }
        guard !phone.isEmpty else {
            return nil
        }
        guard !address.isEmpty else {
            return nil
        }
        guard !price.isEmpty else {
            return nil
        }
        guard !amount.isEmpty else {
            return nil
        }
        guard !totalMoney.isEmpty else {
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
//        self.imageShoe = imageShoe
    }
}
