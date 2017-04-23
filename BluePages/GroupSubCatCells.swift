//
//  GroupSubCatCells.swift
//  BluePages
//
//  Created by Kunal Parekh on 23/10/16.
//  Copyright © 2016 Kunal Parekh. All rights reserved.
//

import UIKit

class GroupSubCatCells: UITableViewCell {
    @IBOutlet weak var countcat: UILabel!

    @IBOutlet weak var star: UIButton!
  
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
