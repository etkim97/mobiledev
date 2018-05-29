//
//  ItemTableViewCell.swift
//  Hooville
//
//  Created by Amanda Nguyen on 4/25/18.
//  Copyright © 2018 Amanda Nguyen. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {
    @IBOutlet weak var userLabel: UILabel!
    
    @IBOutlet weak var reviewLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
