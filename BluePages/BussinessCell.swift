//
//  BussinessCellTableViewCell.swift
//  BluePages
//
//  Created by Kunal Parekh on 23/10/16.
//  Copyright © 2016 Kunal Parekh. All rights reserved.
//

import UIKit

class BussinessCell: UITableViewCell {

    @IBOutlet weak var bussinessName: UILabel!
   
    @IBOutlet var bussinessWebView: UIWebView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }                                                     

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
