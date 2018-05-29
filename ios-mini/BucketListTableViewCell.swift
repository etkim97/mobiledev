//
//  BucketItemTableViewCell.swift
//  Bucket List
//
//  Created by sherriff on 9/15/16.
//  Copyright © 2016 Mark Sherriff. All rights reserved.
//

import UIKit

class BucketListTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var itemNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
