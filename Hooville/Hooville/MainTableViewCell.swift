//
//  MainTableViewCell.swift
//  Hooville
//
//  Created by Elliott Kim on 4/16/18.
//  Copyright © 2018 Amanda Nguyen. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    @IBOutlet weak var itemAddressLabel: UILabel!
    @IBOutlet weak var itemNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
