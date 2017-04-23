//
//  groupCells.swift
//  BluePages
//
//  Created by Kunal Parekh on 22/10/16.
//  Copyright © 2016 Kunal Parekh. All rights reserved.
//

import UIKit

class groupCells: UITableViewCell {

    @IBOutlet var imageIcon: UIImageView!
    @IBOutlet var groupNameLabel: UILabel!
    
    @IBOutlet weak var grCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
