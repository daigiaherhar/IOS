//
//  ShoeTableViewCell.swift
//  ProjectIOS
//
//  Created by Van Tan Vu on 7/25/20.
//  Copyright © 2020 OfTung. All rights reserved.
//

import UIKit

class ShoeTableViewCell: UITableViewCell {
    private var shoeList = [Shoe]()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var shoeName: UILabel!
    @IBOutlet weak var shoePrice: UILabel!
    @IBOutlet weak var shoeImage: UIImageView!
}
