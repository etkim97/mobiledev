//
//  NearbyTableViewCell.swift
//  Hooville
//
//  Created by Elliott Kim on 4/24/18.
//  Copyright © 2018 Amanda Nguyen. All rights reserved.
//

import UIKit

class NearbyTableViewCell: UITableViewCell {
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemDateLabel: UILabel!
    @IBOutlet weak var itemAddressLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
