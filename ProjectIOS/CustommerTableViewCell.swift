//
//  CustommerTableViewCell.swift
//  ProjectIOS
//
//  Created by Tran Thang on 7/25/20.
//  Copyright © 2020 OfTung. All rights reserved.
//

import UIKit

class CustommerTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBOutlet weak var txtName: UILabel!
    @IBOutlet weak var txtPhone: UILabel!
    
    @IBOutlet weak var txtEmail: UILabel!
    @IBOutlet weak var txtAddress: UILabel!
    
}
