//
//  Shoe.swift
//  ProjectIOS
//
//  Created by Van Tan Vu on 7/23/20.
//  Copyright © 2020 OfTung. All rights reserved.
//

import Foundation
import UIKit
class Shoe {
    var name:String
    var amount:String
    var priceEntered:String
    var price:String
    var image:UIImage?
    
    init?(name:String, amount:String, priceEntered:String, price:String, image:UIImage?) {
        guard !name.isEmpty else {
            return nil
        }
        guard !amount.isEmpty else {
            return nil
        }
        guard !priceEntered.isEmpty else {
            return nil
        }
        guard !price.isEmpty else {
            return nil
        }
        
        self.name = name
        self.amount = amount
        self.priceEntered = priceEntered
        self.price = price
        self.image = image
    }
    
}
