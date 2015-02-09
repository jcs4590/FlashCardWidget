//
//  TableViewCell.swift
//  FlashCardApp
//
//  Created by Julio Salamanca on 10/16/14.
//  Copyright (c) 2014 Julio Salamanca. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
  @IBOutlet weak var createdDateLabel: UILabel!
  @IBOutlet weak var labelSetTitle: UILabel!
  @IBOutlet weak var createdByLabel: UILabel!
  @IBOutlet weak var termCountLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
      
    }

}
