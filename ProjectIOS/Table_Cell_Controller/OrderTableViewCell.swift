//
//  OrderTableViewCell.swift
//  ProjectIOS
//
//  Created by NguyenHuynhHoangSang on 7/26/20.
//  Copyright © 2020 OfTung. All rights reserved.
//

import UIKit

class OrderTableViewCell: UITableViewCell {
    private var orderList = [Order]()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var customerName: UILabel!
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var totalMoney: UILabel!
    @IBOutlet weak var shoeIamge: UIImageView!
}
