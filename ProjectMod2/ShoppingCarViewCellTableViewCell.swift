//
//  ShoppingCarViewCellTableViewCell.swift
//  ProjectMod2
//
//  Created by William Sulca Talavera on 25/03/17.
//  Copyright © 2017 Virtualink inc. All rights reserved.
//

import UIKit

class ShoppingCarViewCellTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var imageViewScreen: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblQuantity: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var steeperCount: UIStepper!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
