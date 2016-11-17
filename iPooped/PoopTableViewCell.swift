//
//  PoopTableViewCell.swift
//  iPooped
//
//  Created by Gregory Rudolph-Alverson on 11/9/16.
//  Copyright © 2016 STEiN-Net. All rights reserved.
//

import UIKit

class PoopTableViewCell: UITableViewCell {

    @IBOutlet weak var dateTime: UILabel!
    @IBOutlet weak var rating: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
